//
//  GuestFavoritesService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class GuestFavoritesService: FavoriteService {
    func getFavoritesCount() -> Int {
        print("Getting Favorites From Guest")
        return 0
    }
    
    @Published private var internalEmptyUpdates: [Vehicle] = []
    
    var updates: Published<[Vehicle]>.Publisher { $internalEmptyUpdates }
    
    func isFavorite(_ item: Vehicle) -> Bool {
        false
    }
    
    func favorite(_ item: Vehicle) -> Bool {
        false
    }
    
    func unFavorite(_ item: Vehicle) -> Bool {
        false
    }
    
    func toggleFavorite(for item: Vehicle) -> Bool {
        false
    }
    
    
    
    let favorites: [Vehicle] = []
    
    
    
    
    
}
