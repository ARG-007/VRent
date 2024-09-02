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
    private var drivers: [Driver]
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



