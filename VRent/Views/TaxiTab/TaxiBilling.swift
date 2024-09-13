//
//  TaxiBilling.swift
//  VRent
//
//  Created by Arun R G on 21/08/24.
//

import SwiftUI

struct TaxiBilling: View {
    @EnvironmentObject var taxiService: TaxiManager

    @EnvironmentObject var navMan: Navigation
    @EnvironmentObject var taxiVM: TaxiBookingViewModel
    
    @State private var naivgateToSuccessPage = false
    
    let attributes: TaxiBookingAttributes
    
    var body: some View {
        VStack {
            List {
                Section("Booking Details") {
                    ListRow("Pickup Location", attributes.pickupLocation!.name)
                    ListRow("Drop Location", attributes.dropOffLocation!.name)
                    ListRow("Pickup Time", attributes.pickupTime.formatted(date: .abbreviated, time: .shortened))
                    ListRow("Vehicle Category", attributes.requestedVehicleType.rawValue)
                    ListRow("Passenger Count", attributes.passengerCount.formatted())
                }
                .listStyle(.inset)
                
                Section("Billing Details") {
                    
                    HStack(alignment: .center) {
                        Text("Estimated Distance ")
                        Text(attributes.estimatedDistance.formatted()).bold()
                    }
                    .italic()
                    .frame(maxWidth: .infinity)
                    .alignmentGuide(.listRowSeparatorLeading) {d in d[.leading]}
                    
                    VStack(alignment: .leading) {
                        PriceRow("Driver Fee", attributes.driverCost)
                        Text("\(localizedCurrency(Charges.driverChargePerKm))/km")
                            .font(.caption)
                    }
                    
                    VStack(alignment: .leading) {
                        PriceRow("Vehicle Fee", attributes.vehicleCost)
                        Text("\(localizedCurrency(attributes.requestedVehicleType.standardChargePerKm))/km")
                            .font(.caption)
                    }
                    PriceRow("Total Fare", attributes.totalFare)
                }
            }
        }
        .bottomSticky(cornerRadius: 45.0) {
            SwipeControl(prompt: "Swipe To Book") {
                naivgateToSuccessPage=true
            }
            .navigationDestination(isPresented: $naivgateToSuccessPage) {
                SuccessScreen {
                    try await Task.sleep(for: .seconds(2))
                    let _ = taxiService.registerBooking(for: attributes)
                } onCompletion: {
                    taxiVM.navigateToDetails = false
                }
                .toolbar(.hidden, for: .navigationBar, .bottomBar, .tabBar)
            }
            .padding(10)
        }
        
    
    }
}

#Preview {
    
    var att = TaxiBookingAttributes()
    
    att.pickupLocation = PlacesManager.shared.getPopularPlaces()[0]
    att.dropOffLocation = PlacesManager.shared.getPopularPlaces()[1]
    
    return TaxiBilling(attributes: att)
}
