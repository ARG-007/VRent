//
//  Loader.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation


fileprivate extension Collection {
    func randomPick(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}

class Model: ObservableObject {
    private let places: [SearchLocation]
    private let vehicles: [Vehicle]
    
    var popularPlaces: [SearchLocation] {
        Array(places.randomPick(7))
    }
    
    init() {
        places = load("places.json")
        vehicles = load("vehicles.json")
    }
    
    func fuzzyPlaceSearch(_ name: String)->[SearchLocation] {
        places.filter { $0.name.contains(name) }
    }
    
    func getVehicles()->[Vehicle] {
        vehicles
    }
}


/**
 Give this thing full file name with extension, eg: LoadableJSON.json
 */
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Give me correct name idiot!")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("The data cannot read fooliosh mortal")
    }
    
    do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return try jsonDecoder.decode(T.self, from: data)
    } catch {
        fatalError(error.localizedDescription)
    }
    
}

