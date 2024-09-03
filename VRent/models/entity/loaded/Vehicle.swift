//
//  Vehicle.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation
import CoreLocation
import SwiftUI

class Vehicle: Codable, Identifiable {
    let id: Int
    var owner: Owner
    var spec: VehicleSpecs
    
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

extension Vehicle {
    var yearFormatted: String { 
        spec.year.formatted(.number.grouping(.never))
    }
    
    var name: String {
        "\(spec.make) \(spec.model) \(yearFormatted)"
    }
}

extension Vehicle: Hashable {
    static func == (_ lhs: Vehicle, _ rhs: Vehicle) -> Bool{
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
