//
//  RentingTab.swift
//  CarHub
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI


struct RentingTab: View {
    @State var searchState = RentSearchState()
    
    var body: some View {
        RentingSearchView(searchState: $searchState)
            
    }
}

struct VehicleSearchView {
    
}

#Preview {
    RentingTab()
}
