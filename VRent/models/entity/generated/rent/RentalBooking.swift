//
//  RentalBooking.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import Foundation
import CoreLocation



class RentalBooking: Identifiable, Hashable {
    let id: Int
    var details: RentDetails
    let selectedVehicle: Vehicle
    
    let baseCost: Decimal
    let deliveryCost: Decimal
    let driverCost: Decimal
    let totalCost: Decimal
    
    private var currentStatus: BookingStatus
    private var statusHistory: BookingHistory = [:]
    
    
    
    init(id: Int, for rent: Rentable) {
        self.id = id
        details = rent.rentDetails
        selectedVehicle = rent.vehicle
        
        baseCost = rent.baseCost
        deliveryCost = rent.deliveryCost
        driverCost = rent.driverCost
        totalCost = rent.totalCost
        
        currentStatus = .Booked
        statusHistory.transition(to: currentStatus)
    }
    
    @discardableResult
    func setStatus(newStatus: BookingStatus) -> Bool {
        if (statusHistory.transition(to: newStatus)) {
            currentStatus = newStatus
            return true
        } else {
            return false
        }
    }
    
    
    func getStatus() -> BookingStatus {
        currentStatus
    }
    
    func canTransition(to pseudoStatus: BookingStatus) -> Bool {
        statusHistory.canTransition(to: pseudoStatus)
    }
    
    func getBookingHistory() -> BookingHistory {
        statusHistory
    }
    
    static func == (lhs: RentalBooking, rhs: RentalBooking) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
