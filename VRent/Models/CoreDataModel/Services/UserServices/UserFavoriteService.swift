//
//  UserFavoriteService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation
import Combine

class UserFavoriteService: FavoriteService, ObservableObject {
    private var getCount  = 0
    
    private let user: User
    private let model: Model
    
    init(for user: User, on model: Model) {
        self.user = user
        self.model = model
        
        user.publisher(for: \.favorites).assign(to: &$internalUpdates)
    }
    
    @Published private var internalUpdates: [Vehicle] = []
    
    var updates: Published<[Vehicle]>.Publisher { $internalUpdates }
    var favorites: [Vehicle] {
        print("--------------- Getting Vehicles (Current Count: \(getCount)) ------------- ")
        getCount += 1
        print(user.favorites)
        return user.favorites
    }
    
    
    func isFavorite(_ item: Vehicle) -> Bool {
        user.favorites.contains([item])
    }
    
    func favorite(_ item: Vehicle) -> Bool {
        guard !isFavorite(item) else { return false }
        
        user.addToFavorites(item)
        model.save()
        return true
    }
    
    func unFavorite(_ item: Vehicle) -> Bool {
        guard isFavorite(item) else { return false }

        user.removeFromFavorites(item)
        model.save()
        return true
        
    }
    
    func toggleFavorite(for item: Vehicle) -> Bool {
        let isFavorite = isFavorite(item)
        
        if (isFavorite) {
            user.removeFromFavorites(item)
        } else {
            user.addToFavorites(item)
        }
        
        model.save()
        
        return !isFavorite
    }
    
    
    func getFavoritesCount() -> Int {
        print("Getting Favorites Count: \(favorites.count)")
        return favorites.count
    }
}
