//
//  VehicleType.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI

enum VehicleType: String, Codable, CaseIterable, Identifiable, Hashable {
    private static let assetNamespace = "vehicleIcons"
    
    case HatchBack
    case Sedan
    case SUV
    case MUV
    case Maxicab
    
    var capacity: Int32 {
        switch(self) {
            case .HatchBack: 4
            case .Sedan: 5
            case .SUV: 6
            case .MUV: 7
            case .Maxicab : 13
        }
    }
    
    static func typeWithCapacity(_ capacity: Int32) -> VehicleType {
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
            case .HatchBack: 10.0
            case .Sedan: 13.0
            case .SUV: 16.0
            case .MUV: 20.0
            case .Maxicab: 25.0
        }
    }
    
    var image: Image {
        Image("\(VehicleType.assetNamespace)/\(self.rawValue)")
    }
    
    
}
