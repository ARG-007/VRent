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
    let owner: Owner
    let spec: VehicleSpecs
    
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
}
