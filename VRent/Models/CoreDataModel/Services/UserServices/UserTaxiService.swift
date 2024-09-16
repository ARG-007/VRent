//
//  UserTaxiService.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation

class UserTaxiService: TaxiService {
    
    private let user: User
    private let model: Model
    
    init(for user: User, on model: Model) {
        self.user = user
        self.model = model
    }
    
    
    func getBookings() -> [TaxiBooking] {
        user.taxiBookings
    }
    
    func getBookingsByState() -> [BookingState : [TaxiBooking]] {
        Dictionary(grouping: user.taxiBookings, by: {$0.bookingstatus.current})
    }
    
    @discardableResult
    func registerBooking(for context: TaxiBookingAttributes) -> Bool {
        guard let newTaxi = TaxiBooking(context: model.container.viewContext, data: context) else {
            return false
        }
        
        let randomVehicle = VehicleManager.shared.getVehicles().randomElement()!
        
        newTaxi.assignedVehicle = randomVehicle
        
        user.addToTaxiBookings(newTaxi)
        
        model.save()
        
        return true
    }
    
    func rescheduleBooking(_ booking: TaxiBooking, to nextDate: Date) -> Bool {
        false
    }
    
    func cancelBooking(_ booking: TaxiBooking) -> Bool {
        false
    }
    
    func getBookingsCount() -> Int {
        user.taxiBookings.count
    }
}
