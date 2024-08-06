//
//  VehicleSpecs.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation

enum DriveTrain: String, Codable {
    case FWD
    case RWD
    case AWD
}

enum Fuel: String, Codable {
    case CNG
    case Electric
    case Diesel
    case Petrol
    case BioFuel
    case Hydrogen
    case Hybrid
    case Nuclear
}

enum VehicleType: String, Codable {
    case HatchBack
    case SUV
    case Sedan
    case Maxicab
    case MUV
}

enum Transmission: String, Codable {
    case Manual
    case Automatic
}

class VehicleSpecs: Codable, Identifiable {
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
