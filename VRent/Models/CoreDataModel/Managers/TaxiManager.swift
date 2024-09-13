//
//  TaxiManager.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class TaxiManager: TaxiService {
    
    private let delegatedTaxiService: any TaxiService
    
    init(delegate: any TaxiService) {
        self.delegatedTaxiService = delegate
    }
    
    func getBookings() -> [TaxiBooking] {
        delegatedTaxiService.getBookings()
    }
    
    func getBookingsByState() -> [BookingState : [TaxiBooking]] {
        delegatedTaxiService.getBookingsByState()
    }
    
    func registerBooking(for context: TaxiBookingAttributes) -> Bool {
        delegatedTaxiService.registerBooking(for: context)
    }
    
    func rescheduleBooking(_ booking: TaxiBooking, to nextDate: Date) -> Bool {
        delegatedTaxiService.rescheduleBooking(booking, to: nextDate)
    }
    
    func cancelBooking(_ booking: TaxiBooking) -> Bool {
        delegatedTaxiService.cancelBooking(booking)
    }
    
    func getBookingsCount() -> Int {
        delegatedTaxiService.getBookingsCount()
    }
    
}
