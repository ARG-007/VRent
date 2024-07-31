//
//  RentSearchView.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct RentingSearchView: View {
    @Binding var searchState: RentSearchState
    
    var duration: some View {
        HStack( spacing: 10) {
            Image(systemName: "hourglass")
                .imageScale(.large)
                
            Text(searchState.durationFormatted)
        }
    }
    
    
    var TimePickers: some View {
        VStack {
            HStack(spacing: 20) {
                RentTimePicker(
                    "Pickup Time",
                    selection: $searchState.pickupDate,
                    range: searchState.pickupDateValidRange
                )
                .frame(maxWidth: .infinity)
                
                RentTimePicker(
                    "Drop Time",
                    selection: $searchState.dropDate,
                    range: searchState.dropDateValidRange
                )
                .frame(maxWidth: .infinity)
            }
            .labelsHidden()
            
            duration
                .frame(maxWidth: .infinity)
                .padding()
                .applyBoxShadowEffect()
                .padding(.top, 5)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(value: 0) {
                Text("Pickup Location")
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 10)
            .padding(.vertical, 20)
            .applyBoxShadowEffect()
            
                
            VStack {
                RentDatePicker(
                    "Pickup Date",
                    selection: $searchState.pickupDate,
                    range: searchState.pickupDateValidRange
                )
                
                RentDatePicker(
                    "Drop Date",
                    selection: $searchState.dropDate,
                    range: searchState.dropDateValidRange
                )
                
                TimePickers
                
            }
            .padding()
            .applyBoxShadowEffect()
            
            HStack(spacing: 20) {
                Toggle("Self Driving", isOn: $searchState.isSelfDrive)
                Toggle("Delivery", isOn: $searchState.isRequiredDelivery)
            }
            .padding()
            .applyBoxShadowEffect()
            
            Button("Search", action: {print(searchState)})
                .frame(maxWidth: .infinity)
                .font(.title3)
        }
        .padding()
    }
}

#Preview {
    @State var search = RentSearchState()
    
    return RentingSearchView(searchState: $search)
}
