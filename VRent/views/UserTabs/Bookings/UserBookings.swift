//
//  UserBookings.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct UserBookings: View {
//    @EnvironmentObject var model: Model
    @EnvironmentObject var rentalService: ModelBookingService
    @EnvironmentObject var taxiService: ModelTaxiService
    
    @State private var selection: Bookings = .Rental
    
    private enum Bookings: String, CaseIterable, Identifiable {
        case Rental
        case Taxi
        
        var id: Self {self}
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    Group{
                        if (selection == .Rental) {
                            ForEach(rentalService.getBookings()) { booking in
                                RentOverviewCard(rentDetails: booking)
                            }
                        } else {
                            ForEach(taxiService.getBookings()) { booking in
                                TaxiOverviewCard(taxiDetails: booking)
                                //                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .applyBoxShadowEffect()
                }
                .id(UUID())
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Show Bookings Of", selection: $selection) {
                        ForEach(Bookings.allCases) { bookingType in
                            Text(bookingType.rawValue)
                                .tag(bookingType)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 300)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    NavigationStack {
        UserBookings()
            .initiateServices()
    }
}
