//
//  RentingTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct RentingTab: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var bookingService: ModelBookingService
    @EnvironmentObject var navMan: NavigationManager
    @StateObject private var searchState = RentSearchViewModel()
    @State private var path = NavigationPath()
    
    
    var body: some View {
            
        NavigationStack(path: $navMan.path){
            ScrollView {
                RentingSearchView() {
                    navMan.path.append(RentingScreenPages.searchResults)
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("Rent a Vehicle")
            }
            .navigationDestination(for: RentingScreenPages.self) { page in
                switch(page) {
                case .searchResults:
                    AvailableVehiclesList()
                case .vehicleDetails(let vehicle):
                    RentingVehicleDetails(rentDetails: searchState.getRentSearchQuery(), vehicle: vehicle)
                case .bookingDetails(let rental):
                    RentalBookingOverview(rent: rental)
                case .success(let rental):
                    SuccessScreen {
                        try await Task.sleep(for: .seconds(3))
                        let _ = bookingService.registerBooking(for: rental)
                    } onCompletion: {
                        withAnimation {
                            navMan.path = NavigationPath()
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
