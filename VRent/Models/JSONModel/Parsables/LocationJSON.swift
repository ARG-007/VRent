//
//  Location.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation
import CoreLocation



struct LocationJSON: Codable, Identifiable{
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case name, latitude, longitude
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







