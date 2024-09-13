//
//  TaxiOverviewCard.swift
//  VRent
//
//  Created by Arun R G on 28/08/24.
//

import SwiftUI

struct TaxiOverviewCard: View {
    let taxiDetails: TaxiBooking
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Pickup:** \(taxiDetails.pickupLocation.name) ")
            Text("**Drop:** \(taxiDetails.dropLocation.name) ")
            Text("**Pickup Date:** \(taxiDetails.pickupTime.formatted())")
            Text("**Status :** ") + Text("\(taxiDetails.bookingstatus.current.statusName) on \(taxiDetails.bookingstatus.dateWhen(taxiDetails.bookingstatus.current)!.formatted())")
            
            
        }
    }
}

#Preview {
    TaxiOverviewCard(taxiDetails: UserManager.shared.taxiManager.getBookings()[0])
}
