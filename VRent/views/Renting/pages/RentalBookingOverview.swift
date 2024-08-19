//
//  RentalBookingOverview.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import SwiftUI

struct RentalBookingOverview: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var model: Model
    @EnvironmentObject var navigationManager: RentingNavigation

    let rental: Rentable
    
 
    
    init(rent: Rentable) {
        self.rental = rent
    }
    
    var body: some View {
        VStack {
            priceSection
        }
        .navigationTitle("Booking")
        .safeAreaInset(edge: .bottom) {
            swipeButton
        }
        
    }
    
    @ViewBuilder
    var priceSection: some View {
        List{
            let rentalDetails = rental.rentDetails
            Section ("Rent Details") {
                ListRow("Pickup Location",rentalDetails.pickupLocation!.name )
                ListRow("Pickup Date & Time ", rentalDetails.pickupDate.formatted(date: .abbreviated, time: .shortened))
                ListRow("Drop Date & Time ", rentalDetails.dropDate.formatted(date: .abbreviated, time: .shortened))
                ListRow("Mode of Driving", rentalDetails.isSelfDrive ? "Self Drive" : "Need Driver")
                ListRow("Delivery", rentalDetails.isRequiredDeliver ? "Required" : "Not Required")
                
                ListRow("Total Duration", rentalDetails.duration.converted(to: .hours).value.formatted() + " Hrs")
                
                
                
                Text("Renting Starts ")
            }
            
            Section("Rented Vehicle") {
                let vehicle = rental.vehicle
                ListRow("Model", "\(vehicle.spec.make) \(vehicle.spec.model) \(vehicle.spec.year)")
                PriceRow("Rent Per Hour", vehicle.pricePerHR)
            }
            
            Section("Price Breakup") {
                
                PriceRow("Base Cost: ", rental.baseCost)
                VStack(alignment: .leading) {
                    PriceRow("Driver Rent: ", rental.driverCost)
                    Text("* \(localizedCurrency(100)) for 1 Hour, Total Hours: \(rental.rentDetails.duration.converted(to: .hours).value.formatted()) Hours")
                        .font(.footnote)
                }
                VStack(alignment: .leading) {
                    PriceRow("Delivery Cost: ", rental.deliveryCost)
                    (Text("* \(localizedCurrency(10)) for Each KM, Total KM: ") + Text(Measurement<UnitLength>(value: rental.distance, unit: .kilometers), format: .measurement(width: .abbreviated, usage: .road) ))
                        .font(.footnote)
                }
                PriceRow("Total Cost: ", rental.totalCost)
            }
        }
    }
    
    var swipeButton: some View {
        SwipeControl(prompt: "Swipe To Pay") {
            navigationManager.path.append(1)
        }
        .navigationDestination(for: Int.self) { _ in
            SuccessScreen {
                try await Task.sleep(for: .seconds(3))
                model.bookRental(context: rental)
            } onCompletion: {
                navigationManager.path = NavigationPath()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .background {
            let radius: CGFloat = 45.0
            let shape: some Shape = .rect(
                topLeadingRadius: radius,
                topTrailingRadius: radius
            )
            let backgroundColor: Color = colorScheme == .light ? .white : .offBlack
            
            backgroundColor
                .clipShape(shape)
                .ignoresSafeArea()
                .applyBoxShadowEffect(shape: shape, y: -1)
        }
    }
    
    struct ListRow: View {
        let info: String
        let value: String
        
        init( _ info: String, _ value: String) {
            self.info = info
            self.value = value
        }
        
        var body: some View {
            HStack {
                Text(info)
                Spacer()
                Text(value)
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
        
        RentalBookingOverview(rent: Rentable(vehicle: vehicle, rentDetails: rentQuery))
            .environmentObject(model)
            .environmentObject(RentingNavigation())
        
    }
}
