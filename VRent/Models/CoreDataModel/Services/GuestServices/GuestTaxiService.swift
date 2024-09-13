//
//  GuestTaxiService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class GuestTaxiService: TaxiService {
    func getBookingsCount() -> Int {
        0
    }
    func getBookings() -> [TaxiBooking] {
        []
    }
    
    func getBookingsByState() -> [BookingState : [TaxiBooking]] {
        [:]
    }
    
    func registerBooking(for context: TaxiBookingAttributes) -> Bool {
        false
    }
    
    func rescheduleBooking(_ booking: TaxiBooking, to nextDate: Date) -> Bool {
        false
    }
    
    func cancelBooking(_ booking: TaxiBooking) -> Bool {
        false
    }
    
    
}
