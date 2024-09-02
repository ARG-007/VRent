//
//  RentingTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct RentingTab: View {
    @EnvironmentObject var model: Model
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var searchState = RentSearchViewModel()
    @State private var path = NavigationPath()
    
    
    var body: some View {
            
        NavigationStack(path: $navigationManager.path){
            ScrollView {
                RentingSearchView() {
                    navigationManager.path.append(RentingScreenPages.searchResults)
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
                        model.bookRental(context: rental)
                    } onCompletion: {
                        withAnimation {
                            navigationManager.path = NavigationPath()
                        }
                    }
                    .toolbar(.hidden, for: .navigationBar)
                }
            }
        }
        .environmentObject(searchState)
        .environmentObject(navigationManager)
        
    }
}

#Preview {
    RentingTab()
        .initiateServices(of: previewModel)
}
