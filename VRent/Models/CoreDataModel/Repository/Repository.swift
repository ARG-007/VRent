//
//  Repository.swift
//  VRent
//
//  Created by Arun R G on 13/09/24.
//

import Foundation

class Repository: ObservableObject {
    static let shared = Repository()
    
    private let model: Model = Model.shared
    let vehicleManager: VehicleManager = VehicleManager.shared
    let placesManager: PlacesManager = PlacesManager.shared
    @Published var userManager: UserManager = UserManager.shared
    
    var rentalManager: RentalManager { userManager.rentalManager }
    var taxiManager: TaxiManager { userManager.taxiManager }
    var favoritesManager: FavoritesManager { userManager.favoriteManager }
}
