//
//  TaxiBookingsPage.swift
//  VRent
//
//  Created by Arun R G on 03/09/24.
//

import SwiftUI

struct TaxiBookingsPage: View {
    @EnvironmentObject var taxiService: ModelTaxiService
    @State private var locationSearch: String = ""
    
    var body: some View {
        
        if taxiService.getBookingsCount() > 0 {
            bookings
        } else {
            NoBookingsPage(forCategory: .Taxi)
                .padding()
        }
        
    }
    
    private var bookings: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(bookingsList) { booking in
                    TaxiOverviewCard(taxiDetails: booking)
                        .id(booking.id)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .applyBoxShadowEffect()
                .animation(.bouncy, value: bookingsList)
                
            }
            .padding()
        }
        .searchable(text: $locationSearch,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Pickup or Drop Location")
    }
    
    private var bookingsList: [TaxiBookingData] {
        var bookings = taxiService.getBookings()
        
        if !locationSearch.isEmpty{
            bookings = bookings.filter{ taxiData in
                taxiData.pickupLocation.name.contains(locationSearch)
                || taxiData.dropOffLcoation.name.contains(locationSearch)
            }
        }
        
        return bookings
    }
}

#Preview {
    TaxiBookingsPage()
}
