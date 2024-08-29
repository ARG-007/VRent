//
//  Location.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation
import CoreLocation



struct Location: Codable, Identifiable{
    private static let zeroDistance = Measurement<UnitLength>(value: 0, unit: .kilometers)
    
    let id = UUID()
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
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
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
            return .zeroKilometer
        }
    }
    
}






