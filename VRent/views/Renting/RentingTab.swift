//
//  RentingTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct RentingTab: View {
    @StateObject private var navigationManager = RentingNavigation()
    @State private var searchState = RentSearchState()
    @State private var path = NavigationPath()
    
    
    var body: some View {
            
        NavigationStack(path: $navigationManager.path){
            ScrollView {
                RentingSearchView(searchState: $searchState) {
                    navigationManager.path.append(RentingScreenPages.searchResults)
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("Rent a Vehicle")
                .navigationDestination(for: RentingScreenPages.self) { page in
                    switch(page) {
                    case .searchResults:
                        AvailableVehiclesList(search: $searchState)
                    default:
                        Text("Shit")
                    }
                }
            }
        }
        .environmentObject(navigationManager)
        
    }
}

#Preview {
    RentingTab()
        .environmentObject(previewModel)
}
