//
//  TaxiBilling.swift
//  VRent
//
//  Created by Arun R G on 21/08/24.
//

import Foundation
import CoreLocation



class TaxiBookingData: Identifiable, Hashable, Codable {
    let id: Int
    let pickupLocation: Location
    let dropOffLocation: Location
    
    var pickupTime: Date
    
    let passengerCount: Int
    let requestedVehicleType: VehicleType
    
    var totalFare: Decimal
    var driverCost: Decimal
    var vehicleCost: Decimal
        
    var assignedVehicle: Vehicle?
    var assignedDriver: Driver?
        
    // Distance in KM
    let estimatedDistance: Measurement<UnitLength>
    
    private(set) var currentStatus: BookingStatus
    private(set) var bookingHistory: BookingHistory = [:]
    
    
    var statusUpdateDate: Date {
        bookingHistory[currentStatus]!
    }
    
    init?(id: Int, for taxiBookingAttributes: TaxiBookingAttributes) {
        
        self.id = id
        
        guard let pickupLocationAttribute = taxiBookingAttributes.pickupLocation else {
            return nil
        }
        
        guard let dropOffLocationAttribute = taxiBookingAttributes.dropOffLocation else {
            return nil
        }
        
        pickupLocation = pickupLocationAttribute
        dropOffLocation = dropOffLocationAttribute
        
        pickupTime = taxiBookingAttributes.pickupTime
        passengerCount = taxiBookingAttributes.passengerCount
        requestedVehicleType = taxiBookingAttributes.requestedVehicleType
        
        estimatedDistance = taxiBookingAttributes.estimatedDistance
        
        driverCost = taxiBookingAttributes.driverCost
        vehicleCost = taxiBookingAttributes.vehicleCost
        
        totalFare = taxiBookingAttributes.totalFare
        
        currentStatus = .Booked
        bookingHistory.transition(to: .Booked)
    }
    
    @discardableResult
    func setStatus(to newStatus: BookingStatus) -> Bool {
        if(bookingHistory.transition(to: newStatus)) {
            currentStatus = newStatus
            return true
        }
        return false
    }
    
    func canTransition(to pseudoStatus: BookingStatus) -> Bool {
        bookingHistory.canTransition(to: pseudoStatus)
    }
    
    static func == (lhs: TaxiBookingData, rhs: TaxiBookingData) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
