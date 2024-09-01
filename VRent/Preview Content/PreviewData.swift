//
//  PreviewData.swift
//  VRent
//
//  Created by Arun R G on 26/08/24.
//

import Foundation

fileprivate extension TaxiBookingAttributes {
    init(pickup: Location, drop: Location, pickupTime: Date, passengerCount: Int, requestedVehicleType: VehicleType) {
        self.pickupLocation = pickup
        self.dropOffLocation = drop
        self.pickupTime = pickupTime
        self.passengerCount = passengerCount
        self.requestedVehicleType = requestedVehicleType
    }
}

struct PreviewData {
    static var data = PreviewData()
    
    private(set) var model = Model()
    
    private init() {
        initModel()
    }
    
    private func initModel() {
        makeRentalBooking()
        markFavorites()
        makeTaxiBookings()
    }
    
    
    private func markFavorites() {
        let favoriteService = ModelFavoriteService(model)
        
        for _ in 1...10 {
            if let randomVehicle = model.getVehicles().randomElement() {
                favoriteService.favorite(randomVehicle)
            }
        }
    }
    
    private func makeRentalBooking() {
        var rentDetails: [Rentable] = []
        
        for i in 1...10 {
            let pickupLocation = model.popularPlaces[0]
            let pickupTime = Calendar.current.date(byAdding: .hour, value: .random(in: 2*i...10*i), to: .now)!
            let dropTime = Calendar.current.date(byAdding: .hour, value: .random(in: 4...10*i), to: pickupTime)!
            
            
            let tempDetails = RentDetails(pickupLocation: pickupLocation, pickupDate: pickupTime, dropDate: dropTime, isSelfDrive: .random(), isRequiredDeliver: .random())
            
            if let vehicle = model.getVehicles().randomElement() {
                rentDetails.append(Rentable(vehicle: vehicle, rentDetails: tempDetails))
            }
        }
        
        for booking in  rentDetails {
            model.bookRental(context: booking)
        }
    }
    
    private func makeTaxiBookings() {
        var taxiBookings: [TaxiBookingAttributes] = []
        
        for i in 1...10 {
            let pickupTime = Calendar.current.date(byAdding: .minute, value: i*30, to: .now)!
            let locations = model.popularPlaces.randomPick(2)
            let passengerCount = Int.random(in: 1...3)
            let vehicleType = VehicleType.typeWithCapacity(passengerCount)
            taxiBookings.append(TaxiBookingAttributes(pickup: locations[0], drop: locations[1], pickupTime: pickupTime, passengerCount: passengerCount, requestedVehicleType: vehicleType))
            
        }
        
        
        
        for taxiBooking in taxiBookings {
            
            let _ = model.bookTaxi(for: taxiBooking)
        }
    }
}

var previewModel = PreviewData.data.model
