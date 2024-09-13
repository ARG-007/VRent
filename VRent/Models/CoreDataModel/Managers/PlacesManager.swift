//
//  PlacesManager.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class PlacesManager: PlacesService {
    
    static let shared: PlacesManager = PlacesManager()
    
    private let model = Model.shared
    
    private lazy var places: [Location] = fetchPlaces()
    private lazy var randomLocations: [Location] = {Array(places.shuffled().prefix(10))}()
    
    private func fetchPlaces() -> [Location] {
        (try? model.container.viewContext.fetch(LocationCD.fetchRequest()).map {$0.location}) ?? []
    }
    
    
    func getPopularPlaces() -> [Location] {
        randomLocations
    }
    
    func fuzzyPlaceSearch(query: String) -> [Location] {
        places.filter {$0.name.contains(query)}
    }
    
//    func getUserLocation() -> Location {
//        
//    }
    
    
   
}
