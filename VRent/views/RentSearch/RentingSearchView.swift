//
//  RentSearchView.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct RentingSearchView: View {
    @Binding var searchState: RentSearchState
    @State private var showLocationSelectionSheet: Bool = false
    let onSubmit: ()->Void
    
    init(searchState: Binding<RentSearchState>) {
        self.init(searchState: searchState) {}
    }
    
    init(searchState: Binding<RentSearchState>, onSubmit: @escaping ()->Void) {
        self._searchState = searchState
        self.onSubmit = onSubmit
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
    
    var locationSelector: some View {
        Button {
            showLocationSelectionSheet = true
        } label: {
            HStack {
                Image(systemName: "location.magnifyingglass")
                    .imageScale(.medium)
                Text(searchState.pickupLocation?.name ?? "Pickup Location")
                    .font(.callout)
                Spacer()
            }
            .foregroundStyle(.foreground.opacity(0.7))
            .padding()
        }
        .border(RoundedRectangle(cornerRadius: 15.0), style: .tint, lineWidth: 1.5)
        
        
    }
    
    
    var body: some View {
            VStack(spacing: 20) {
                VStack {
                    
                    locationSelector
                        .padding(.bottom)
                        .sheet(isPresented: $showLocationSelectionSheet) {
                            LocationFinder(selection: $searchState.pickupLocation) {
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
}

#Preview {
    @State var search = RentSearchState()
    
    return RentingSearchView(searchState: $search)
        .environmentObject(Model())
}
