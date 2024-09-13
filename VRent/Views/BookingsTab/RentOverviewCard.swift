//
//  RentOverviewCard.swift
//  VRent
//
//  Created by Arun R G on 26/08/24.
//

import SwiftUI

struct RentOverviewCard: View {
    let rentDetails: RentalBooking
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Rented On:**  \(rentDetails.bookingStatus.dateWhen(.Booked)!.formatted())")
            Text("**Rent Durtation:** \(rentDetails.duration.converted(to: .hours).value.formatted()) Hrs")
            Text("**Pickup Date:**  \(rentDetails.pickupTime.formatted(date: .abbreviated, time: .shortened))")
            Text("**Drop Date:** \(rentDetails.dropTime.formatted(date: .abbreviated, time: .shortened))")
            Text("**Pickup Location:** \(rentDetails.pickupLocation.name)")
            Text("**Driving:** \(rentDetails.isSelfDriving ? "Self Drive" :  "Assign an Driver")")
            Text("**Vehicle Selected:** \(rentDetails.selectedVehicle.name)")
            Text("**Total Price:** \(localizedCurrency(rentDetails.totalCost))")
        }
        
    }
}

#Preview {
    
    RentOverviewCard(rentDetails: UserManager.shared.rentalManager.getBookings()[0])
}
