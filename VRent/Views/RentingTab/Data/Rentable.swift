//
//  Renting.swift
//  VRent
//
//  Created by Arun R G on 08/08/24.
//

import Foundation

struct Rentable: Hashable {
    let vehicle: Vehicle
    let rentDetails: RentDetails
    
    init(vehicle: Vehicle, rentDetails: RentDetails) {
        self.vehicle = vehicle
        self.rentDetails = rentDetails
    }
    
    var distance: Measurement<UnitLength> {
        rentDetails.pickupLocation!.distance(from: vehicle.location)
    }
    
    var baseCost: Decimal {
        vehicle.pricePerHR * Decimal(rentDetails.duration.converted(to: .hours).value)
    }
    
    var deliveryCost: Decimal {
        (rentDetails.isRequiredDeliver ? Charges.driverChargePerKm : 0) * Decimal(distance.value)
    }
    
    var driverCost: Decimal {
        (rentDetails.isSelfDrive ? 0 : Charges.vehicleDeliveryChargePerKm) * Decimal(rentDetails.duration.converted(to: .hours).value)
    }
    
    var totalCost: Decimal {
        baseCost + deliveryCost + driverCost
    }
}


