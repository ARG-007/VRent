//
//  TaxiBookingAttributes.swift
//  VRent
//
//  Created by Arun R G on 16/08/24.
//

import Foundation



struct TaxiBookingAttributes {
    var pickupLocation: SearchLocation?
    var dropOffLocation: SearchLocation?
    
    var pickupTime: Date
    
    var passengerCount: Int 
    var requestedVehicleType: VehicleType
    
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
