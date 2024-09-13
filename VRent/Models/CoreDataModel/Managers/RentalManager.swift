//
//  RentalManager.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class RentalManager: RentalService {
    
    private let delegatedRentalService: any RentalService
    
    init(delegate: any RentalService) {
        delegatedRentalService = delegate
    }
    
    func getBookings() -> [RentalBooking] {
        delegatedRentalService.getBookings()
    }
    
    func getBookingsByState() -> [BookingState : [RentalBooking]] {
        delegatedRentalService.getBookingsByState()
    }
    
    func registerBooking(for context: Rentable) -> Bool {
        delegatedRentalService.registerBooking(for: context)
    }
    
    func rescheduleBooking(_ booking: RentalBooking, to nextDate: Date) -> Bool {
        delegatedRentalService.rescheduleBooking(booking, to: nextDate)
    }
    
    func cancelBooking(_ booking: RentalBooking) -> Bool {
        delegatedRentalService.cancelBooking(booking)
    }
    
    func getBookingsCount() -> Int {
        delegatedRentalService.getBookingsCount()
    }
    
}
