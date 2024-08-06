//
//  Vehicle.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation
import CoreLocation

class Vehicle: Codable, Identifiable {
    let id: Int
    let owner: Owner
    let spec: VehicleSpecs
    
    let addedOn: Date
    let broughtOnYear: Int16
    let pricePerHR: Double
    let images: [URL]
    
    let latitude: Double
    let longitude: Double
    
    let ratings: Double
    let tripsCompleted: Int
    
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
