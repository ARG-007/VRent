//
//  RentalService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

protocol RentalService: ObservableObject{
    
    func getBookingsCount() -> Int
    func getBookings() -> [RentalBooking]
    func getBookingsByState() -> [BookingState: [RentalBooking]]
    func registerBooking(for context: Rentable) -> Bool
    func rescheduleBooking(_ booking: RentalBooking, to nextDate: Date) -> Bool
    func cancelBooking(_ booking: RentalBooking) -> Bool

}
