//
//  PlacesService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation


protocol PlacesService {
    func getPopularPlaces() -> [Location]
    func fuzzyPlaceSearch(query: String) -> [Location]
    func getUserLocation() -> Location
}
