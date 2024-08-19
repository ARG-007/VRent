//
//  Rating.swift
//  VRent
//
//  Created by Arun R G on 07/08/24.
//

import Foundation
import SwiftUI


struct Rating: Codable {
    let average: Double
    let tripsCompleted: Int
}

extension Rating {
    
    var color: Color {
        switch(average) {
            case 0..<2.5: .red
            case 2.5..<4.0: .orange
            default: .green
        }
    }
    
}
