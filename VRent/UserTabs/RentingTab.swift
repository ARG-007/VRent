//
//  RentingTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI


struct RentingTab: View {
    @State var searchState = RentSearchState()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            RentingSearchView(searchState: $searchState) {
                path.append(1)
            }
            .frame(maxHeight: .infinity)
            .navigationDestination(for: Int.self) { _ in
                VehicleSearchView(search: $searchState)
            }
        }
    }
}

#Preview {
    RentingTab()
        .environmentObject(Model())
}
