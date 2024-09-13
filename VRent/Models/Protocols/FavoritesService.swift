//
//  FavoritesService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

protocol FavoriteService: ObservableObject {
    
    var favorites: [Vehicle] { get }
    
    var updates: Published<[Vehicle]>.Publisher { get }
    
    func getFavoritesCount() -> Int
    func isFavorite(_ item: Vehicle) -> Bool
    func favorite(_ item: Vehicle) -> Bool
    func unFavorite(_ item: Vehicle) -> Bool
    func toggleFavorite(for item: Vehicle) -> Bool
    
}
