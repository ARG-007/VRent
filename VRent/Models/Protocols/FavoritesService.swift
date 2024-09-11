//
//  FavoritesService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

protocol FavoriteService: ObservableObject {
    associatedtype Item: Hashable
    
    var favorites: [Item] { get }
    
//    var updates: Published<[Item]>.Publisher { get }
    
    func isFavorite(_ item: Item) -> Bool
    func favorite(_ item: Item) -> Bool
    func unFavorite(_ item: Item) -> Bool
    func toggleFavorite(for item: Item) -> Bool
    
}
