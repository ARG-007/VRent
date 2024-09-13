//
//  TaxiService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

protocol TaxiService: ObservableObject{
    
    func getBookingsCount() -> Int
    func getBookings() -> [TaxiBooking]
    func getBookingsByState() -> [BookingState: [TaxiBooking]]
    func registerBooking(for context: TaxiBookingAttributes) -> Bool
    func rescheduleBooking(_ booking: TaxiBooking, to nextDate: Date) -> Bool
    func cancelBooking(_ booking: TaxiBooking) -> Bool
}
