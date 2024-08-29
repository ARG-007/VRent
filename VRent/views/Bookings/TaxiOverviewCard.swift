//
//  TaxiOverviewCard.swift
//  VRent
//
//  Created by Arun R G on 28/08/24.
//

import SwiftUI

struct TaxiOverviewCard: View {
    let taxiDetails: TaxiBookingData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Pickup:** \(taxiDetails.pickupLocation.name) ")
            Text("**Drop:** \(taxiDetails.dropOffLcoation.name) ")
            Text("**Pickup Date:** \(taxiDetails.pickupTime.formatted())")
            Text("**Status :** ") + Text("\(taxiDetails.currentStatus) on \(taxiDetails.statusUpdateDate.formatted())")
            
            
        }
    }
}

#Preview {
    TaxiOverviewCard(taxiDetails: previewModel.taxiBookings[0])
}
