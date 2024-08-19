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
            RentingSearchView(searchState: $searchState) {
                navigationManager.path.append(RentingScreenPages.searchResults)
            }
            .frame(maxHeight: .infinity)
            .navigationTitle("Search Page")
            .navigationDestination(for: RentingScreenPages.self) { page in
                switch(page) {
                case .searchResults:
                    AvailableVehiclesList(search: $searchState)
                default:
                    Text("Shit")
                }
            }
            
            
        }
        .environmentObject(navigationManager)
        
    }
}

#Preview {
    RentingTab()
        .environmentObject(Model())
}
