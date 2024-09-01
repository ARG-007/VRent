//
//  RentingVehicleDetails.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import SwiftUI

struct RentingVehicleDetails: View {
    let vehicle: Vehicle
    let rentDetails: RentDetails
    let tempBooking: Rentable
    
    @State private var presentPriceBreakUpSheet = false
    @Environment(\.colorScheme) var colorScheme
    
    
    init(rentDetails: RentDetails, vehicle: Vehicle) {
        self.rentDetails = rentDetails
        self.vehicle = vehicle
        
        tempBooking = Rentable(vehicle: vehicle, rentDetails: rentDetails)
    }
    
    var body: some View {
        
        ScrollView {
            VehicleDetails(vehicle: vehicle)
                .toolbar {
                    FavoriteButton(vehicle: vehicle)
                }
                .padding()
        }
        .bottomSticky(cornerRadius: 25) {
            bottomBar
        }

        .sheet(isPresented: $presentPriceBreakUpSheet) {
            priceBreakSheet
                .presentationDetents([.fraction(0.5)])
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        
            
    }
    
 

    
    private var bottomBar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(tempBooking.totalCost.formatted(.currency(code:Locale.current.currency?.identifier ?? "INR")))
                    .fontWeight(.bold)
                    .font(.title3)
                    
                
                Button {
                    presentPriceBreakUpSheet = true
                } label: {
                     Text("Price Breakup ")
                        .textCase(.uppercase)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.tint)
                }
                
            }
            .padding(.horizontal, 20)
            
            NavigationLink (value: RentingScreenPages.bookingDetails(tempBooking)) {
                Text("Book This Car")
                    .padding()
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(in: .capsule)
                    .backgroundStyle(.tint)
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                    .ignoresSafeArea(.container, edges: [.bottom])
            }
        }
        .padding(.top, 10)
    }
    
    var priceBreakSheet: some View {
        VStack(alignment: .trailing) {
            
            
            List {
                Button(role: .cancel) {
                    presentPriceBreakUpSheet = false
                } label: {
                    Text("Close")
                }
                

                PriceRow("Base Cost: ", tempBooking.baseCost)
                
                if(!rentDetails.isSelfDrive) {
                    VStack(alignment: .leading) {
                        PriceRow("Driver Rent: ", tempBooking.driverCost)
                        Text("* \(localizedCurrency(Charges.driverChargePerHr)) for 1 Hour, Total Hours: \(tempBooking.rentDetails.duration.converted(to: .hours).value.formatted()) Hours")
                            .font(.footnote)
                    }
                }
                
                if(rentDetails.isRequiredDeliver) {
                    VStack(alignment: .leading) {
                        PriceRow("Delivery Cost: ", tempBooking.deliveryCost)
                        (Text("* \(localizedCurrency(Charges.vehicleDeliveryChargePerKm)) for Each KM, Total KM: ") + Text(tempBooking.distance, format: .measurement(width: .abbreviated, usage: .road)))
                            .font(.footnote)
                    }
                }
                PriceRow("Total Cost: ", tempBooking.totalCost)
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        let model = Model()
        let vehicle = Model().getVehicles()[0]
        
        let rentQuery = RentDetails(
            pickupLocation: model.popularPlaces[0],
            pickupDate: .now.advanced(by: 2*3600),
            dropDate: .now.advanced(by: 6*3600),
            isSelfDrive: false,
            isRequiredDeliver: true
        )
        
        RentingVehicleDetails( rentDetails: rentQuery, vehicle: vehicle)
            .initiateServices(of: previewModel)
    }
}
