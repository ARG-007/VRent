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
    

    let rental: Rentable
    let onSwipe: () -> Void
    
 
    
    init(rent: Rentable,  onSwipe: @escaping ()->Void) {
        self.rental = rent
        self.onSwipe = onSwipe
    }
    
    var body: some View {
        VStack {
            priceSection
        }
        .navigationTitle("Booking")
        .bottomSticky(cornerRadius: 45) {
            swipeButton
                .padding(.horizontal, 10)
                .padding(.top, 10)
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
                
                
                if(rentalDetails.pickupDate < Calendar.current.date(byAdding: .day, value: 2, to: .now)!) {
                    HStack(alignment: .center) {
                        Text("Renting Starts ")
                        + Text(rentalDetails.pickupDate, format: .relative(presentation: .named, unitsStyle: .wide))
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                }
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
                    Text("* \(localizedCurrency(Charges.driverChargePerHr)) for 1 Hour, Total Hours: \(rental.rentDetails.duration.converted(to: .hours).value.formatted()) Hours")
                        .font(.footnote)
                }
                VStack(alignment: .leading) {
                    PriceRow("Delivery Cost: ", rental.deliveryCost)
                    (Text("* \(localizedCurrency(Charges.vehicleDeliveryChargePerKm)) for Each KM, Total KM: ") + Text(rental.distance, format: .measurement(width: .abbreviated, usage: .road) ))
                        .font(.footnote)
                }
                PriceRow("Total Cost: ", rental.totalCost)
            }
        }
    }
    
    var swipeButton: some View {
        SwipeControl(prompt: "Swipe To Book") {
            onSwipe()
        }
//        .navigationDestination(for: Int.self) { _ in
//            
//        }
        
//        .background {
//            let radius: CGFloat = 45.0
//            let shape: some Shape = .rect(
//                topLeadingRadius: radius,
//                topTrailingRadius: radius
//            )
//            let backgroundColor: Color = colorScheme == .light ? .white : .offBlack
//            
//            backgroundColor
//                .clipShape(shape)
//                .ignoresSafeArea()
//                .applyBoxShadowEffect(shape: shape, y: -1)
//        }
    }
    
    
    
    
}




#Preview {
    NavigationStack {
        
        
        let model = Model.shared
        let vehicle = VehicleManager.shared.getVehicles()[0]
        let offset = 16.0
        
        let rentQuery = RentDetails(
            pickupLocation: PlacesManager.shared.getPopularPlaces()[0],
            pickupDate: .now.advanced(by: offset*3600),
            dropDate: .now.advanced(by: (offset+6)*3600),
            isSelfDrive: false,
            isRequiredDeliver: true
        )
        
        RentalBookingOverview(rent: Rentable(vehicle: vehicle, rentDetails: rentQuery)) {}
            .environmentObject(model)
            .environmentObject(NavigationManager())
            .navigationDestination(for: RentingScreenPages.self) { page in
                switch(page) {
                case .success(let rental): SuccessScreen {
                    try await Task.sleep(for: .seconds(3))
                    let _ = UserManager.shared.rentalManager.registerBooking(for: rental)
                } onCompletion: {
                    
                }
                default: Text("Shit")
                    
                }
            }
        
    }
}
