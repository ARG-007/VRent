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
    
    @State var presentPriceBreakUpSheet = false
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
        .safeAreaInset(edge: .bottom, spacing: 0) {
            bottomBar
        }
        .sheet(isPresented: $presentPriceBreakUpSheet, content: {
            priceBreakSheet
                .presentationDetents([.fraction(0.35)])
        })
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        
            
    }
    
 

    
    private var bottomBar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(tempBooking.totalCost.formatted(.currency(code:Locale.current.currency?.identifier ?? "INR")))
                    .fontWeight(.bold)
                    
                
                Button {
                    presentPriceBreakUpSheet = true
                } label: {
                     Text("Price Breakup ")
                        .textCase(.uppercase)
                        .fontWeight(.bold)
                        .foregroundStyle(.tint)
                }
                
            }
            .padding(.horizontal, 20)
            
            NavigationLink {
              RentalBookingOverview(rent: tempBooking)
            } label: {
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
        .background {
            let radius: CGFloat = 25.0
            let shape: some Shape = .rect(topLeadingRadius: radius, topTrailingRadius: radius)
            let backgroundColor: Color = colorScheme == .light ? .white : .offBlack
            
            backgroundColor
                .clipShape(shape)
                .ignoresSafeArea()
                .applyBoxShadowEffect(shape: shape, y: 0)
        }
    }
    
    var priceBreakSheet: some View {
        VStack {
            List {
                PriceRow("Base Cost: ", tempBooking.baseCost)
                VStack(alignment: .leading) {
                    PriceRow("Driver Rent: ", tempBooking.driverCost)
                    Text("* \(localizedCurrency(100)) for 1 Hour, Total Hours: \(tempBooking.rentDetails.duration.converted(to: .hours).value.formatted()) Hours")
                        .font(.footnote)
                }
                VStack(alignment: .leading) {
                    PriceRow("Delivery Cost: ", tempBooking.deliveryCost)
                    (Text("* \(localizedCurrency(10)) for Each KM, Total KM: ") + Text(Measurement<UnitLength>(value: tempBooking.distance, unit: .kilometers), format: .measurement(width: .abbreviated, usage: .road) ))
                        .font(.footnote)
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
            .environmentObject(model)
    }
}
