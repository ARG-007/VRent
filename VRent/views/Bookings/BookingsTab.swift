//
//  BookingsTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct BookingsTab: View {
    @EnvironmentObject var model: Model
    @State private var selection: Bookings = .Rental
    
    private enum Bookings: String, CaseIterable, Identifiable {
        case Rental
        case Taxi
        
        var id: Self {self}
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    if (selection == .Rental) {
//                        Text("Bookings")
                        ForEach(model.rentalBookings) { booking in
                            RentOverviewCard(rentDetails: booking)
                        }
                    } else {
//                        Text("Taxi")
                        ForEach(model.taxiBookings) { booking in
                            TaxiOverviewCard(taxiDetails: booking)
                        }
                    }
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
        BookingsTab()
            .initiateServices(of: previewModel)
    }
}
