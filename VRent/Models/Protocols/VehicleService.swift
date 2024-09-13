//
//  VehicleService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

protocol VehicleService: ObservableObject {
    func getVehicles() -> [Vehicle]
}
