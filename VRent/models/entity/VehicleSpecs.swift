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

enum VehicleType: String, Codable, CaseIterable, Identifiable {
    
    
    case HatchBack
    case Sedan
    case SUV
    case MUV
    case Maxicab
    
    var capacity: Int {
        switch(self) {
            case .HatchBack: 4
            case .Sedan: 5
            case .SUV: 6
            case .MUV: 7
            case .Maxicab : 13
        }
    }
    
    static func typeWithCapacity(_ capacity: Int) -> VehicleType {
        switch(capacity) {
            case 0...4 : .HatchBack
            case 5: .Sedan
            case 6: .SUV
            case 7: .MUV
            default: .Maxicab
        }
    }
    
    var id: Self {
        self
    }

    
    var standardChargePerKm: Decimal {
        switch(self) {
            case .HatchBack: 100.0
            case .Sedan: 130.0
            case .SUV: 160.0
            case .MUV: 200.0
            case .Maxicab: 250.0
        }
    }
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
