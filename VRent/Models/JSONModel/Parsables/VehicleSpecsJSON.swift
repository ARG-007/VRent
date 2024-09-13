//
//  VehicleSpecs.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation
import SwiftUI



struct VehicleSpecsJSON: Codable, Identifiable {
    let id: Int
    
    let make: String
    let model: String
    let year: Int16
    let type: VehicleType
    
    let capacity: Int16
    let fuelCapacity: Float
    let isLuxury: Bool
    
    let driveTrain: DriveTrain
    let fuelType: Fuel
    let transmission: Transmission
    
}

extension VehicleSpecsJSON: Hashable {
    static func == (lhs: VehicleSpecsJSON, rhs: VehicleSpecsJSON) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
