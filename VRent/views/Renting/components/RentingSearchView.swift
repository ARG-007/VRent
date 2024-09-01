//
//  RentSearchView.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct RentingSearchView: View {
    @EnvironmentObject var searchState: RentSearchViewModel
    @State private var showLocationSelectionSheet: Bool = false
    let onSubmit: ()->Void
    
    
    init(onSubmit: @escaping ()->Void = {}) {
        self.onSubmit = onSubmit
    }
    
    var body: some View {
            VStack(spacing: 20) {
                VStack {
                    
                    LocationField(prompt: searchState.pickupLocation?.name ?? "Pickup Location") {
                        showLocationSelectionSheet = true
                    }
                        .padding(.bottom)
                        .sheet(isPresented: $showLocationSelectionSheet) {
                            LocationFinder("Pickup Location", selection: $searchState.pickupLocation) {
                                showLocationSelectionSheet = false
                            }
                        }
                    
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
                    
                    
                    HStack(spacing: 20) {
                        Toggle("Self Driving", isOn: $searchState.isSelfDrive)
                        Toggle("Delivery", isOn: $searchState.isRequiredDelivery)
                    }
                    .padding(.top)
                    
                }
                .padding()
                .applyBoxShadowEffect()
                
                Button  {
                    if(searchState.pickupLocation != nil) {
                        onSubmit()
                    }
                    else {
                        showLocationSelectionSheet = true
                    }
                } label: {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(.background)
                        .background() {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.tint)
                        }
                }
                .accessibilityLabel(Text("Search"))
                
            }
            .padding(.horizontal)
    }
    
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
            .padding()
            
            duration
                .frame(maxWidth: .infinity)
                .padding()
                .background() {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.tint.opacity(0.1))
                    
                }
                .padding(.top, 5)
        }
    }

    
    
    
}

#Preview {
    @StateObject var search = RentSearchViewModel()
    
    return RentingSearchView()
        .initiateServices(of: previewModel)
        .environmentObject(search)
}
