//
//  Loader.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation
import SwiftUI

typealias UserFavoriteVehicles = [User: [Vehicle]]
typealias UserRentals = [User: [RentalBooking]]
typealias UserTaxiBookings = [User: [TaxiBookingData]]
typealias Users = [User]

class Model: ObservableObject {
    
    static let shared = Model()
    
    // Loaded from JSON from app Bundle
    let places: [Location]
    let vehicles: [Vehicle]
    private(set) var owner: [Owner] = []
    private(set) var specs: [VehicleSpecs] = []
    private(set) var drivers: [Driver]
    
    // Generated after loading for either testing or production
    @Published var users: Users = []
    
    // Each User has list of these
    @Published var rentalBookings: UserRentals = [:]
    @Published var taxiBookings: UserTaxiBookings = [:]
    @Published var favorites: UserFavoriteVehicles = [:]
    
    lazy var popularPlaces: [Location] = {
        Array(places.randomPick(7))
    }()
    
    private init() {
        places = load("places.json")
        vehicles = load("vehicles.json")
        drivers = load("drivers.json")
        
        
        loadModel()
        
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
    
    func loadModel() {
        let defaults = UserDefaults.standard
        let jsonDecoder = JSONDecoder()
        
        do {
            if let loadedUsers = defaults.data(forKey: "users"),
               let decodedUsers = try? jsonDecoder.decode(Users.self, from: loadedUsers) {
                print(loadedUsers)
                users = decodedUsers
            } else {
                print("No Users Found, Empty List Initialization")
                users = []
            }
            
            if let loaded = defaults.data(forKey: "userRentals"),
               let decoded = try? jsonDecoder.decode(UserRentals.self, from: loaded) {
                print(loaded)
                rentalBookings = decoded
            } else {
                print("No Rentals Found, Empty Dict Initialization")
                rentalBookings = [:]
            }
            
            if let loaded = defaults.data(forKey: "userTaxi"),
               let decoded = try? jsonDecoder.decode(UserTaxiBookings.self, from: loaded) {
                print(loaded)
                taxiBookings = decoded
            } else {
                print("No Taxi's Found, Empty Dict Initialization")
                taxiBookings = [:]
            }
            
            if let loaded = defaults.data(forKey: "userFavoriteVehicles"),
               let decoded = try? jsonDecoder.decode(UserFavoriteVehicles.self, from: loaded) {
                print(loaded)
                favorites = decoded
            } else {
                print("No Favorites Found, Empty Dict Initialization")
                favorites = [:]
            }
        } catch {}
        
    }
    
    func saveModel() {
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        
        if let encoded = try? jsonEncoder.encode(users) {
            print(encoded)
            defaults.set(encoded, forKey: "users")
        }
        
        if let encoded = try? jsonEncoder.encode(rentalBookings) {
            print(encoded)
            defaults.set(encoded, forKey: "userRentals")
        }
        
        if let encoded = try? jsonEncoder.encode(taxiBookings) {
            print(encoded)
            defaults.set(encoded, forKey: "userTaxi")
        }
        
        if let encoded = try? jsonEncoder.encode(favorites) {
            print(encoded)
            defaults.set(encoded, forKey: "userFavoriteVehicles")
        }
        
        

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



