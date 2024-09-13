//
//  UserRentalService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class UserRentalService: RentalService {
    
    private let user: User
    private let model: Model
    
    init(for user: User, on model: Model) {
        self.user = user
        self.model = model
    }
    
    func getBookings() -> [RentalBooking] {
        user.rentalBookings
    }
    
    func getBookingsByState() -> [BookingState: [RentalBooking]] {
        Dictionary(grouping: user.rentalBookings , by: { $0.bookingStatus.current })
    }
    
    @discardableResult
    func registerBooking(for context: Rentable) -> Bool {
        guard let newRental = RentalBooking(context: model.container.viewContext, data: context) else { return false }
        
        user.addToRentalBookings(newRental)
        
        model.save()
        
        return true
    }
    
    func rescheduleBooking(_ booking: RentalBooking, to nextDate: Date) -> Bool {
        false
    }
    
    func cancelBooking(_ booking: RentalBooking) -> Bool {
        false
    }
    
    func getBookingsCount() -> Int {
        user.rentalBookings.count
    }
}
