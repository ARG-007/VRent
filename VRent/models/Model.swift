//
//  Loader.swift
//  VRent
//
//  Created by Arun R G on 01/08/24.
//

import Foundation

class Model: ObservableObject {
    private let places: [Location]
    private let vehicles: [Vehicle]
    private var drivers: [Driver] = []
    @Published var rentalBookings: [RentalBooking] = []
    @Published var taxiBookings: [TaxiBookingData] = []
    @Published var favorites: [Vehicle] = []
    
    var popularPlaces: [Location] {
        Array(places.randomPick(7))
    }
    
    init() {
        places = load("places.json")
        vehicles = load("vehicles.json")
        drivers = load("drivers.json")
    }
    
    func fuzzyPlaceSearch(_ name: String)->[Location] {
        places.filter { $0.name.contains(name) }
    }
    
    func getVehicles()->[Vehicle] {
        vehicles
    }
    
    func bookRental(context: Rentable) {
        rentalBookings.append(RentalBooking(id: rentalBookings.count, for: context))
    }
    
    
    /**
     Checks whether the given vehicle is an Favorite,
     Returns `true` if the vehicle is favorite
     `false` if the vehilce is not an favorite
     */
    func isFavorite(_ vehicle: Vehicle) -> Bool {
        getIndexInFavorites(of: vehicle) != nil
    }
    
    /**
     Favorites the vehicle for user in the model,
     Returns `true` if the vehicle is registered as favorite
     `false` if the vehilce is already an favorite
     */
    @discardableResult
    func favorite(_ vehicle: Vehicle) -> Bool {
        guard !isFavorite(vehicle) else {
            return false
        }
        
        favorites.append(vehicle)
        return true
    }
    
    /**
     Unfavorites the vehicle for user in the model,
     Returns `true` if the vehicle is unfavorited or,
     `false` if the vehicle is already unfavorited
     */
    func unFavorite(_ vehicle: Vehicle) -> Bool {
        guard let index =  favorites.firstIndex(where: { $0.id == vehicle.id } ) else {
            return false
        }
        
        favorites.remove(at: index)
        
        return true
    }

    /**
     Toggles the favorite status of vehicle, returns the updated favorite status of the vehicle:
     `true` if the vehicle is now an favorite
     `false` if the vehicle is now not an favorite
     */
    func toggleFavorite(for vehicle: Vehicle) -> Bool {
        if let index = getIndexInFavorites(of: vehicle) {
            favorites.remove(at: index)
            return false
        } else {
            favorites.append(vehicle)
            return true
        }
    }
    
    private func getIndexInFavorites(of vehicle: Vehicle) -> Int? {
        favorites.firstIndex(where: { $0.id == vehicle.id } )
    }
    
    func getFavorites() -> [Vehicle] {
        favorites
    }
    
    func bookTaxi(for attributes: TaxiBookingAttributes) -> Bool {
        guard let booking = TaxiBookingData(id: taxiBookings.count,for: attributes) else {
            return false
        }
        
        let vehicle = vehicles.filter { $0.spec.type == booking.requestedVehicleType || $0.spec.type.capacity > booking.passengerCount }.randomElement()!
        let driver = drivers.randomElement()!
        
        booking.assignedVehicle = vehicle
        booking.assignedDriver = driver
            
        taxiBookings.append(booking)
        
        return true
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



