//
//  Vehicle.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation
import CoreLocation
import SwiftUI

struct VehicleJSON: Codable, Identifiable {
    let id: Int
    var owner: OwnerJSON
    var spec: VehicleSpecsJSON
    
    let addedOn: Date
    let broughtOnYear: Int16
    let pricePerHR: Decimal
    let images: [URL]
    
    let latitude: Double
    let longitude: Double
    
    let ratings: Rating
    
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

}

extension VehicleJSON {
    var yearFormatted: String {
        spec.year.formatted(.number.grouping(.never))
    }
    
    var name: String {
        "\(spec.make) \(spec.model) \(yearFormatted)"
    }
}

extension VehicleJSON: Hashable {
    static func == (_ lhs: VehicleJSON, _ rhs: VehicleJSON) -> Bool{
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
