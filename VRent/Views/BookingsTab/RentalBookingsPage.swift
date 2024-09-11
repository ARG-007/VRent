//
//  RentalBookingsPage.swift
//  VRent
//
//  Created by Arun R G on 03/09/24.
//

import SwiftUI

struct RentalBookingsPage: View {
    
    @EnvironmentObject var rentalService: ModelBookingService
    
    @State private var modelSearch: String = ""
    
    var body: some View {
        
        if rentalService.getBookingsCount() > 0 {
            bookings
        } else {
            NoBookingsPage(forCategory: .Rental)
                .padding()
        }
        
    }
    
    private var bookings: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(bookingsList) { booking in
                    RentOverviewCard(rentDetails: booking)
                        .id(booking.id)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .applyBoxShadowEffect()
                .animation(.bouncy, value: bookingsList)

            }
            .searchable(text: $modelSearch, placement: .navigationBarDrawer, prompt: Text("Search by Vehicle Model"))
            .padding()
        }
    }
    
    private var bookingsList: [RentalBooking] {
        var bookings = rentalService.getBookings()
        
        if(!modelSearch.isEmpty) {
            bookings = bookings.filter { booking in
                booking.selectedVehicle.name.contains(modelSearch)
            }
        }
        
        
        return bookings
    }
    
}

#Preview {
    RentalBookingsPage()
}
