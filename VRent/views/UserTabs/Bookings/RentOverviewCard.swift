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
            Text("**Rented On:**  \(rentDetails.getBookingHistory()[.Booked]!.formatted())")
            Text("**Rent Durtation:** \(rentDetails.details.duration.converted(to: .hours).value.formatted()) Hrs")
            Text("**Pickup Date:**  \(rentDetails.details.pickupDate.formatted(date: .abbreviated, time: .shortened))")
            Text("**Drop Date:** \(rentDetails.details.dropDate.formatted(date: .abbreviated, time: .shortened))")
            Text("**Pickup Location:** \(rentDetails.details.pickupLocation!.name)")
            Text("**Driving:** \(rentDetails.details.isSelfDrive ? "Self Drive" :  "Assign an Driver")")
            Text("**Vehicle Selected:** \(rentDetails.selectedVehicle.name)")
            Text("**Total Price:** \(localizedCurrency(rentDetails.totalCost))")
        }
        
    }
}

#Preview {
    
    RentOverviewCard(rentDetails: ModelBookingService.shared.getBookings()[0])
}
