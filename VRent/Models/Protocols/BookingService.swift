//
//  BookingService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

protocol BookingService: ObservableObject {
    
    func getBookings() -> [BookingStatus: RentalBooking]
    func registerBooking(for context: RentalBooking) -> Bool
    func rescheduleBooking(_ booking: RentalBooking, to nextDate: Date) -> Bool
    func cancelBooking(_ booking: RentalBooking) -> Bool

}
