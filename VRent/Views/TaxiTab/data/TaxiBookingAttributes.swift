//
//  TaxiBookingAttributes.swift
//  VRent
//
//  Created by Arun R G on 16/08/24.
//

import Foundation



struct TaxiBookingAttributes {
    
    var pickupLocation: Location?
    var dropOffLocation: Location?
    
    var pickupTime: Date
    
    var passengerCount: Int 
    var requestedVehicleType: VehicleType
    
    
    var estimatedDistance: Measurement<UnitLength> {
        pickupLocation?.distance(from: dropOffLocation) ?? .zeroKilometer
    }
    
    var driverCost: Decimal {
        Decimal(estimatedDistance.value) * Charges.driverChargePerKm
    }
    
    var vehicleCost: Decimal {
        Decimal(estimatedDistance.value) * requestedVehicleType.standardChargePerKm
    }
    
    var totalFare: Decimal {
        driverCost + vehicleCost + Charges.convinenceCharge
    }
    
    
    init() {
        pickupTime = Calendar.current.date(byAdding: .minute, value: 10, to: Date.now)!
        requestedVehicleType = VehicleType.HatchBack
        passengerCount = requestedVehicleType.capacity
    }
    
    
    
    init(basedOn details: TaxiBookingAttributes) {
        self = details
        
        if(self.pickupTime < Date.now) {
            self.pickupTime = Calendar.current.date(byAdding: .minute, value: 10, to: Date.now)!
        }
    }
    
    
    
    
    
}
