//
//  TaxiService.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

protocol TaxiService: ObservableObject {
    
    func getBookings() -> [BookingStatus: TaxiBookingData]
    func registerBooking(for context: TaxiBookingData) -> Bool
    func rescheduleBooking(_ booking: TaxiBookingData, to nextDate: Date) -> Bool
    func cancelBooking(_ booking: TaxiBookingData) -> Bool
}
