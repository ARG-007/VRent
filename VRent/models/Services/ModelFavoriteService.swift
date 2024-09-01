//
//  ModelFavoriteService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation
import Combine


class ModelFavoriteService: FavoriteService {
    private var model: Model
    
    private var anyCancellable: AnyCancellable?
    
    var favorites: [Vehicle] {
        model.favorites
    }
    
    init(_ model: Model) {
        self.model = model
        
        anyCancellable = model.$favorites.sink { [weak self] vehicles in
            self?.objectWillChange.send()
        }
        
    }
    
    /**
     Checks whether the given vehicle is an Favorite,
     Returns `true` if the vehicle is favorite
     `false` if the vehilce is not an favorite
     */
    func isFavorite(_ vehicle: Vehicle) -> Bool {
        getIndexInFavorites(of: vehicle) != nil
    }
    
    /**
     Favorites the vehicle for user in the model,
     Returns `true` if the vehicle is registered as favorite
     `false` if the vehilce is already an favorite
     */
    @discardableResult
    func favorite(_ vehicle: Vehicle) -> Bool {
        guard !isFavorite(vehicle) else {
            return false
        }
        
        model.favorites.append(vehicle)
        return true
    }
    
    /**
     Unfavorites the vehicle for user in the model,
     Returns `true` if the vehicle is unfavorited or,
     `false` if the vehicle is already unfavorited
     */
    func unFavorite(_ vehicle: Vehicle) -> Bool {
        guard let index =  favorites.firstIndex(where: { $0.id == vehicle.id } ) else {
            return false
        }
        
        model.favorites.remove(at: index)
        
        return true
    }

    /**
     Toggles the favorite status of vehicle, returns the updated favorite status of the vehicle:
     `true` if the vehicle is now an favorite
     `false` if the vehicle is now not an favorite
     */
    func toggleFavorite(for vehicle: Vehicle) -> Bool {
        if let index = getIndexInFavorites(of: vehicle) {
            model.favorites.remove(at: index)
            return false
        } else {
            model.favorites.append(vehicle)
            return true
        }
    }
    
    private func getIndexInFavorites(of vehicle: Vehicle) -> Int? {
        favorites.firstIndex { $0.id == vehicle.id }
    }
}
