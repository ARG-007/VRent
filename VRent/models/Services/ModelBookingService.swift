//
//  ModelBookingService.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI

class ModelBookingService: ObservableObject {
    private var model: Model
    
    @CurrentUser private var currentUser
    @AppStorage("next_bookings_id") var next_booking_id: Int = 0
    
    static let shared = ModelBookingService()
    
    private init() {
        model = Model.shared
    }
    
    func getBookings() -> [RentalBooking] {
        if let currentUser {
            return model.rentalBookings[currentUser]!
        }
        return []
    }
    
    func getCategorizedBooking() -> [BookingStatus: [RentalBooking]] {
        return Dictionary(grouping:  getBookings(), by: {$0.getStatus()})
    }
    
    @discardableResult
    func registerBooking(for context: Rentable) -> Bool {
        if let currentUser {
            model.rentalBookings[currentUser]!.append(RentalBooking(id: next_booking_id,for: context))
            next_booking_id += 1
            return true
        }
        return false
    }
    
    func rescheduleBooking(_ booking: RentalBooking, to nextDate: Date) -> Bool {
        if let currentUser {
            guard model.rentalBookings[currentUser]!.contains(where: {$0.id == booking.id}) else {
                return false
            }
            if (booking.canTransition(to: .Rescheduled)) {
                booking.details.pickupDate = nextDate
                booking.setStatus(newStatus: .Rescheduled)
                return true
            }
        }
        return false
    }
    
    func cancelBooking(_ booking: RentalBooking) -> Bool {
        if let currentUser {
            guard model.rentalBookings[currentUser]!.contains(where: {$0.id == booking.id}) else {
                return false
            }
            if (booking.canTransition(to: .Cancelled)) {
                booking.setStatus(newStatus: .Cancelled)
                return true
            }
        }
        return false
        
    }
    
    
}
