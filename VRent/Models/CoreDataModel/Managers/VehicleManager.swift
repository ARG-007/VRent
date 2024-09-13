//
//  VehicleManager.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class VehicleManager: VehicleService {
    
    static let shared: VehicleManager = VehicleManager()
    
    private let model = Model.shared
    
    private lazy var vehicles: [Vehicle] = fetchVehicles()
    
    private func fetchVehicles() -> [Vehicle] {
        (try? model.container.viewContext.fetch(Vehicle.fetchRequest())) ?? []
    }
    
    func getVehicles() -> [Vehicle] {
        vehicles
    }
}
