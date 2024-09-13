//
//  GuestRentalService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class GuestRentalService: RentalService {
    func getBookingsCount() -> Int {
        0
    }
    
    
    func getBookingsByState() -> [BookingState : [RentalBooking]] {
        [:]
    }
    
    func getBookings() -> [RentalBooking] {
        []
    }
    
    func registerBooking(for context: Rentable) -> Bool {
        false
    }
    
    func rescheduleBooking(_ booking: RentalBooking, to nextDate: Date) -> Bool {
        false
    }
    
    func cancelBooking(_ booking: RentalBooking) -> Bool {
        false
    }
    
    
}
