//
//  TaxiTab.swift
//  VRent
//
//  Created by Arun R G on 16/08/24.
//

import SwiftUI

struct TaxiTab: View {
    @State private var taxiDetails = TaxiBookingState()
    
    @State private var locationSheet: LocationSelectionTab? = nil
    
    enum LocationSelectionTab: Int, Identifiable {
        case pickup
        case drop
        
        var id: Int {self.rawValue}
    }
    
    var body: some View {
        VStack {
            LocationField(prompt: taxiDetails.pickupLocation?.name ?? "Pickup Location") {
                locationSheet = .pickup
            }
            .applyBoxShadowEffect()
            
            LocationField(prompt: taxiDetails.dropOffLocation?.name ?? "Drop Location") {
                locationSheet = .drop
            }
        }
        .padding()
        .sheet(item: $locationSheet) { tab in
            
        }
    }
}

#Preview {
    TaxiTab()
}
