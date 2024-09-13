//
//  FavoritesManager.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class FavoritesManager: ObservableObject {

    @Published private var updatePublisher: [Vehicle] = []
    
    private let delegatedFavoriteService: any FavoriteService
    
    init(delegate: any FavoriteService) {
        self.delegatedFavoriteService = delegate

        delegate.updates.assign(to: &$updatePublisher)

    }
    
    var favorites: [Vehicle] { delegatedFavoriteService.favorites }
    
    func isFavorite(_ item: Vehicle) -> Bool {
        delegatedFavoriteService.isFavorite(item)
    }
    
    func favorite(_ item: Vehicle) -> Bool {
        delegatedFavoriteService.favorite(item)
    }
    
    func unFavorite(_ item: Vehicle) -> Bool {
        delegatedFavoriteService.unFavorite(item)
    }
    
    func toggleFavorite(for item: Vehicle) -> Bool {
        delegatedFavoriteService.toggleFavorite(for: item)
    }
    
    func getFavoritesCount() -> Int {
        delegatedFavoriteService.getFavoritesCount()
    }
}
