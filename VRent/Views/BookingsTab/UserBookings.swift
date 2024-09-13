//
//  UserBookings.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

enum Bookings: String, CaseIterable, Identifiable {
    case Rental
    case Taxi
    
    var id: Self {self}
}


struct UserBookings: View {
//    @EnvironmentObject var model: Model
    @EnvironmentObject var rentalService: RentalManager
    @EnvironmentObject var taxiService: TaxiManager
    
    @State private var selection: Bookings = .Rental
    
    
    var body: some View {
        NavigationStack{
            Group {
                if selection == .Rental {
                    RentalBookingsPage()
                } else {
                    TaxiBookingsPage()
                }
            }
            .navigationTitle("Bookings")
            .navigationBarTitleDisplayMode(.inline)
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
            
        }
        
    }
}

#Preview {
    NavigationStack {
        UserBookings()
            .initiateServices()
    }
}
