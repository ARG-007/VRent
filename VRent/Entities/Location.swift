//
//  Location.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation
import CoreLocation
import CoreData


public class Location: NSObject, Codable, Identifiable, NSSecureCoding  {
    public static var supportsSecureCoding: Bool = true
    
    public let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case name, latitude, longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    
    init(name: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - NSCoding Conformance
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longitude, forKey: "longitude")
    }
    
    public required init?(coder: NSCoder) {
        id = coder.decodeObject(of: NSUUID.self, forKey: "id") as? UUID ?? UUID()
        name = coder.decodeObject(of: NSString.self, forKey: "name") as? String ?? ""
        latitude = coder.decodeDouble(forKey: "latitude")
        longitude = coder.decodeDouble(forKey: "longitude")
    }
    
    // MARK: - Coding Protocol Synthesizetion Override
    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        super.init()
    }
}

extension Location {
    /**
     Distance in Kilometers between `self` and `from` CLLocation
     */
    func distance(from rhs: CLLocation) -> Measurement<UnitLength> {
        Measurement<UnitLength>(value: self.location.distance(from: rhs), unit: .meters).converted(to: .kilometers)
    }
    
    /**
     Distance in Kilometers between `self` and `from`
     */
    func distance(from rhs: Location) -> Measurement<UnitLength> {
        self.distance(from: rhs.location)
    }
    
    /**
        If `from` is non nil, returns distance between `self` and `from` in Kilometers else returns 0 Kilometers
     */
    func distance(from rhs: Location?) -> Measurement<UnitLength> {
        if let rhs {
            return self.distance(from: rhs)
        } else {
            return Measurement(value: 0, unit: .kilometers)
        }
    }
    
}

extension Location {
    public override var description: String {
        """
        id: \(id)
        Name: \(name)
        Latitude: \(latitude)
        Longitude: \(longitude)
        """
    }
}

@objc(LocationSecureCodingTransformer)
class LocationSecureCodingTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: LocationSecureCodingTransformer.self))
    
    override static var allowedTopLevelClasses: [AnyClass] {
        [Location.self]
    }
    
    static func register() {
        print("Register: \(name)")
        let transformer = LocationSecureCodingTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
