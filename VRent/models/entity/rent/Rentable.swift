//
//  Renting.swift
//  VRent
//
//  Created by Arun R G on 08/08/24.
//

import Foundation

struct Rentable {
    let vehicle: Vehicle
    let rentDetails: RentDetails
    
    var distance: Double {
        rentDetails.pickupLocation!.location.distance(from: vehicle.location)/1000
    }
    
    var baseCost: Decimal {
        vehicle.pricePerHR * Decimal(rentDetails.duration.converted(to: .hours).value)
    }
    
    var deliveryCost: Double {
        (rentDetails.isRequiredDeliver ? 10 : 0) * distance
    }
    
    var driverCost: Double {
        (rentDetails.isSelfDrive ? 0 : 100) * rentDetails.duration.converted(to: .hours).value
    }
    
    var totalCost: Decimal {
        baseCost + Decimal(deliveryCost + driverCost)
    }
    
    
    
}
