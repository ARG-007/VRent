//
//  RentalBooking.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import Foundation
import CoreLocation


class RentalBooking {
    let details: RentDetails
    let selectedVehicle: Vehicle
    
    let baseCost: Decimal
    let deliveryCost: Decimal
    let driverCost: Decimal
    let totalCost: Decimal
    
    var status: RentalStatus
    
    
    enum RentalStatus {
        case InComplete
        case Booked
        case Active(Date)
        case Completed(Date)
        case Cancelled(Date)
    }

    
    var vehiclePosition: CLLocation
    
    let rentedOn: Date
    var endedOn: Date?
    
    init(for rent: Rentable) {
        details = rent.rentDetails
        selectedVehicle = rent.vehicle
        
        baseCost = rent.baseCost
        deliveryCost = Decimal(rent.deliveryCost)
        driverCost = Decimal(rent.driverCost)
        totalCost = rent.totalCost
        
        rentedOn = .now
        
        status = .Booked
        
        vehiclePosition = rent.vehicle.location
        
    }
    
}
