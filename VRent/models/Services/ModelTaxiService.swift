//
//  ModelTaxiService.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI


class ModelTaxiService: ObservableObject {
    private var model: Model
    
    @CurrentUser private var currentUser
    @AppStorage("next_taxi_id") var next_taxi_id: Int = 0
    
    static let shared = ModelTaxiService()
    
    private init() {
        model = Model.shared
    }
    
    func getBookings() -> [TaxiBookingData] {
        if let currentUser {
            return model.taxiBookings[currentUser]!
        }
        return []
    }
    
    func getCategorizedBooking() -> [BookingStatus: [TaxiBookingData]] {
        return Dictionary(grouping: getBookings(), by: {$0.currentStatus})
    }
    
    @discardableResult
    func registerBooking(for context: TaxiBookingAttributes) -> Bool {
        if let currentUser {
            model.taxiBookings[currentUser]!.append(TaxiBookingData(id: next_taxi_id,for: context)!)
            next_taxi_id += 1
            return true
        }
        return false
    }
    
    func rescheduleBooking(_ booking: TaxiBookingData, to nextDate: Date) -> Bool {
        if let currentUser {
            guard model.taxiBookings[currentUser]!.contains(where: {$0.id == booking.id}) else {
                return false
            }
            if (booking.canTransition(to: .Rescheduled)) {
                booking.pickupTime = nextDate
                booking.setStatus(to: .Rescheduled)
                return true
            }
        }
        return false
    }
    
    func cancelBooking(_ booking: TaxiBookingData) -> Bool {
        if let currentUser {
            guard model.taxiBookings[currentUser]!.contains(where: {$0.id == booking.id}) else {
                return false
            }
            if (booking.canTransition(to: .Cancelled)) {
                booking.setStatus(to: .Cancelled)
                return true
            }
        }
        return false
        
    }
    
    

}
