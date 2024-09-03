//
//  Loader.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation

class Model: ObservableObject {
    
    static let shared = Model()
    
    // Loaded from JSON from app Bundle
    let places: [Location]
    let vehicles: [Vehicle]
    private(set) var owner: [Owner] = []
    private(set) var specs: [VehicleSpecs] = []
    private(set) var drivers: [Driver]
    
    // Generated after loading for either testing or production
    @Published var users: [User] = []
    
    // Each User has list of these
    @Published var rentalBookings: [ User : [RentalBooking] ] = [:]
    @Published var taxiBookings: [ User : [TaxiBookingData] ] = [:]
    @Published var favorites: [ User : [Vehicle] ] = [:]
    
    var popularPlaces: [Location] {
        Array(places.randomPick(7))
    }
    
    private init() {
        places = load("places.json")
        vehicles = load("vehicles.json")
        drivers = load("drivers.json")
        
        resolveVehicleStruct()
    }
    
    private func resolveVehicleStruct() {
        for vehicle in vehicles {
            if let owner = owner.first(where: {$0.id == vehicle.owner.id }) {
                vehicle.owner = owner
            } else {
                self.owner.append(vehicle.owner)
            }
            
            if let spec = specs.first(where: {$0.id == vehicle.spec.id }) {
                vehicle.spec = spec
            } else {
                self.specs.append(vehicle.spec)
            }
        }
        
        
    }
    
    func fuzzyPlaceSearch(_ name: String)->[Location] {
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
        fatalError("The data cannot be read foolish mortal")
    }
    
    do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return try jsonDecoder.decode(T.self, from: data)
    } catch {
        fatalError(error.localizedDescription)
    }
    
}



