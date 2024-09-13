//
//  TaxiTab.swift
//  VRent
//
//  Created by Arun R G on 16/08/24.
//

import SwiftUI

enum LocationSelectionTab: Int, Identifiable {
    case pickup
    case drop
    
    var id: Int {self.rawValue}
}

struct TaxiTab: View {
    @EnvironmentObject var model: Model
    
    @StateObject private var taxiDetails = TaxiBookingViewModel()
    @EnvironmentObject var navMan: NavigationManager
    
    @State private var showPopover = false
    @StateObject private var nav = Navigation()
    
    @GuestMode var guestMode
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(spacing: 10) {
                        TaxiLocationSelector(
                            pickupSelection: $taxiDetails.pickupLocation,
                            dropSelection: $taxiDetails.dropOffLocation,
                            locationSelection: $taxiDetails.locationSelectionSheet,
                            swapActionHandler: taxiDetails.swapLocation)
                        
                        Text("Pickup and Drop Locations Must Be Different")
                            .opacity(taxiDetails.locationSame ? 1 : 0)
                            .foregroundStyle(.red)
                            .font(.caption.bold())
                    }
                    
                    VStack {
                        Text("Pickup Date and Time")
                        DatePicker("Pickup Time", selection: $taxiDetails.pickupTime, in: Date.now.advanced(by: 30*60)...Date.now.advanced(by: 3600 * 24 * 10))
                            .frame(maxWidth: .infinity)
                    }
                    .bold()
                    .padding()
                    .applyInnerShadowEffect(shape: .rect(cornerRadius: 10), blurRadius: 2, y:0)
                    .labelsHidden()
                    
                    ViewThatFits(in: .horizontal) {
                        HStack(alignment: .firstTextBaseline) {
                            vehiclePicker
                            passengerStepper
                        }
                        
                        VStack {
                            vehiclePicker
                            passengerStepper
                        }
                    }
                    .padding()
                    .applyInnerShadowEffect(blurRadius: 2,y: 0)
                    
                    
                    if(!guestMode) {
                        Button (action: taxiDetails.continueToBook ) {
                            Text("Book Vehicle")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .applyInnerShadowEffect(shape:.rect(cornerRadius: 10),background: .tint)
                        }
                    } else {
                        Button (action: {navMan.showLogin = true}) {
                            Text("Sign In To Continue")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .applyInnerShadowEffect(shape:.rect(cornerRadius: 10),background: .tint)
                        }
                    }
                    
                    
                    
                }
                .padding()
                .sheet(item: $taxiDetails.locationSelectionSheet) { tab in
                    if(tab == .pickup) {
                        LocationFinder("Pickup Location", selection: $taxiDetails.pickupLocation)
                    } else {
                        LocationFinder("Drop Location", selection: $taxiDetails.dropOffLocation)
                    }
                }
                .applyBoxShadowEffect(blurRadius: 2, y:0)
                .padding()
                .navigationTitle("Intercity Taxi")
                .navigationDestination(isPresented: $taxiDetails.navigateToDetails){
                    TaxiBilling(attributes: taxiDetails.getAttributes())
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
        .environmentObject(taxiDetails)
        .environmentObject(nav)

    }
    
    
    var vehiclePicker: some View {
        VStack(alignment: .leading) {
            Text("Vehicle Category")
                .bold()
                
            
            
            VehiclePicker(selection: $taxiDetails.vehicleType)
                
                .frame(maxWidth: .infinity, alignment: .center)
                .applyInnerShadowEffect(shape: .rect(cornerRadius: 10), blurRadius: 2, x: 0, y: 1)
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    
    var passengerStepper: some View {
        VStack(alignment: .leading) {
            Text("Passengers")
                .bold()
            
            PassengerStepper(passenger: $taxiDetails.passengerCount)
            .labelsHidden()
            .padding(5)
            .applyInnerShadowEffect(shape: .rect(cornerRadius: 10), blurRadius: 2, x: 0, y: 1)
//            .border(.rect(cornerRadius: 10), style: .black.opacity(0.33))
        }
    }
}

#Preview {
    TaxiTab()
        .environmentObject(Model.shared)
}
