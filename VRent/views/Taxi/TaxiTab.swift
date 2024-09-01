//
//  TaxiTab.swift
//  VRent
//
//  Created by Arun R G on 16/08/24.
//

import SwiftUI



struct TaxiTab: View {
    @EnvironmentObject var model: Model
    
    @StateObject private var taxiDetails = TaxiBookingViewModel()
    
    
    @State private var locationSheet: LocationSelectionTab? = nil
    @State private var showPopover = false
    
    enum LocationSelectionTab: Int, Identifiable {
        case pickup
        case drop
        
        var id: Int {self.rawValue}
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        if case .invalid(let error) = taxiDetails.pickupLocationField {
                            Text(error)
                                .foregroundStyle(.red)
                                .font(.callout)
                        }
                        LocationField(prompt: taxiDetails.pickupLocation?.name ?? "Pickup Location") {
                            locationSheet = .pickup
                        }
                        
                        
                        if case .invalid(let error) = taxiDetails.dropOffLocationField {
                            Text(error)
                                .foregroundStyle(.red)
                                .font(.callout)
                        }
                        LocationField(prompt: taxiDetails.dropOffLocation?.name ?? "Drop Location") {
                            locationSheet = .drop
                        }
                        
                    }
                    .overlay(alignment: .trailing) {
                        Button(action: taxiDetails.swapLocation) {
                            Image(systemName: "arrow.up.and.down.circle.fill")
                                .font(.largeTitle)
                        }
                        .applyBoxShadowEffect(shape: .circle)
                        .padding(.trailing)
                    }
                    
                    VStack {
                        Text("Pickup Date and Time")
                        DatePicker("Pickup Time", selection: $taxiDetails.pickupTime, in: Date.now...)
                            .frame(maxWidth: .infinity)
                    }
                    .bold()
                    .padding()
                    .applyInnerShadowEffect(shape: .rect(cornerRadius: 10), blurRadius: 2, y:0)
                    .labelsHidden()
                    //                .border(.rect(cornerRadius: 10), style: .tint, lineWidth: 1.5)
                    
                    HStack(alignment: .firstTextBaseline) {
                        
                        
                        VStack(alignment: .leading) {
                            Text("Vehicle Category")
                                .bold()
                                .scaledToFit()
                            
                            
                            
                            VStack{
                                Image(systemName: "car.side")
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(3/2, contentMode: .fit)
                                    .frame(minHeight: 60)
                                    .padding()
                                
                                HStack(spacing: 5) {
                                    let pickerShape = UnevenRoundedRectangle(topLeadingRadius: 10, bottomTrailingRadius: 10)
                                    Text(localizedCurrency(taxiDetails.vehicleType.standardChargePerKm)+"/hr")
                                        .padding(.horizontal,5)
                                    
                                    
                                    
                                    Picker("Vehicle Category", selection: $taxiDetails.vehicleType) {
                                        ForEach(VehicleType.allCases) { vtype in
                                            Text(vtype.rawValue)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .applyBoxShadowEffect(shape: pickerShape, blurRadius: 2.7)
                                    .mask {
                                        GeometryReader { reader in
                                            let offset: CGFloat = 10
                                            
                                            pickerShape
                                                .frame(width: reader.size.width + offset, height: reader.size.height + offset)
                                                .offset(x: -offset-1, y: -offset-1)
                                                .compositingGroup()
                                        }
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .applyInnerShadowEffect(shape: .rect(cornerRadius: 10), blurRadius: 2, x: 0, y: 1)
                            
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Passengers")
                                .bold()
                            
                            VStack(alignment: .center) {
                                Image(systemName: "person.fill")
                                
                                TextField("Passenger Count", value: $taxiDetails.passengerCount, format: .number)
                                //                            .padding(.leading)
                                    .contentTransition(.identity)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 50)
                                
                                Stepper("Passenger Count",value: $taxiDetails.passengerCount)
                                    .keyboardType(.numberPad)
                                
                            }
                            .labelsHidden()
                            //                    .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                            .border(.rect(cornerRadius: 10), style: .black.opacity(0.33))
                        }
                        
                        
                        
                    }
                    
                    .padding()
                    .applyInnerShadowEffect(blurRadius: 2,y: 0)
                    
                    Button {
                        let _ = model.bookTaxi(for: taxiDetails.getAttributes())
                    } label: {
                        Text("Book Vehicle")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .applyInnerShadowEffect(shape:.rect(cornerRadius: 10),background: .tint)
                    }
                    //            .background(.tint, in: .rect(cornerRadius: 10))
                    
                    
                }
                .padding()
                .sheet(item: $locationSheet) { tab in
                    if(tab == .pickup) {
                        LocationFinder("Pickup Location", selection: $taxiDetails.pickupLocation) {
                            locationSheet = .drop
                        }
                    } else {
                        LocationFinder("Drop Location", selection: $taxiDetails.dropOffLocation) {
                            locationSheet = .pickup
                        }
                    }
                }
                .applyBoxShadowEffect(blurRadius: 2, y:0)
                .padding()
                .navigationTitle("Intercity Taxi")
            }
        }
        
        
        
    }
}

#Preview {
    TaxiTab()
        .environmentObject(previewModel)
}
