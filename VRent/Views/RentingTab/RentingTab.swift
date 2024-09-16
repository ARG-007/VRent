//
//  RentingTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct RentingTab: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var bookingService: RentalManager
    @StateObject private var searchState = RentSearchViewModel()
    @State private var nav = NavigationPath()
    
    
    var body: some View {
            
        NavigationStack(path: $nav) {
            ScrollView {
                RentingSearchView() {
                    
                    nav.append(RentingScreenPages.searchResults)
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("Rent a Vehicle")
            }
            .navigationDestination(for: RentingScreenPages.self) { page in
                let _ = print(page)
                switch(page) {
                case .searchResults:
                    AvailableVehiclesList()
                case .vehicleDetails(let vehicle):
                    RentingVehicleDetails(rentDetails: searchState.getRentSearchQuery(), vehicle: vehicle)
                case .bookingDetails(let rental):
                    RentalBookingOverview(rent: rental) {
                        nav.append(RentingScreenPages.success(rental))
                    }
                case .success(let rental):
                    SuccessScreen {
                        try await Task.sleep(for: .seconds(3))
                        let _ = bookingService.registerBooking(for: rental)
                    } onCompletion: {
                        withAnimation {
                            nav = NavigationPath()
                        }
                    }
                    .toolbar(.hidden, for: .navigationBar)
                }
                
            }
        }
        .environmentObject(searchState)
        
        
    }
}

#Preview {
    RentingTab()
        .initiateServices()
        .environmentObject(NavigationManager())
}
