//
//  AvailableVehiclesList.swift
//  VRent
//
//  Created by Arun R G on 06/08/24.
//

import SwiftUI
import CoreLocation

struct AvailableVehiclesList: View {
    @EnvironmentObject var search: RentSearchViewModel
    @EnvironmentObject var model: Model
    @Environment(\.colorScheme) var colorScheme
    
    @Orientation var orientation

    var body: some View {
        ScrollView {
            if(orientation == .portrait || orientation == .portraitUpsideDown) {
                LazyVStack {
                    results
                }
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    results
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Available Cars")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    var results: some View {
        ForEach(model.getVehicles()){ vehicle in
            NavigationLink(value: RentingScreenPages.vehicleDetails(vehicle))
            {
                createVehicleCard(for: vehicle)
            }
        }
    }
    
    func createVehicleCard(for vehicle: Vehicle) -> some View {
        VStack(spacing: 0) {
            VehicleCard(for: vehicle)
            
            
            HStack(alignment: .top) {
                
                Label(search.pickupLocation?.distance(from: vehicle.location).formatted(.measurement(width: .abbreviated, usage: .road)) ?? "0 KM", systemImage: "ruler")
//                Label(getDistance(vehicle.location), systemImage: "ruler")
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text( localizedCurrency(Decimal(search.duration.converted(to: .hours).value) * vehicle.pricePerHR))
                    Text("excluding other fees")
                        .font(.caption2)
                }
            }
            .foregroundStyle(.foreground)
            .padding(16)
            
        }
        .applyBoxShadowEffect()
        .padding()
    }
    
    private func getDistance(_ location: CLLocation) -> String {
        let measurement = Measurement(value: getDistanceFromSearchLocation(location), unit: UnitLength.meters)
        
        return measurement.formatted(.measurement(width: .abbreviated, usage: .road))
    }
    
    private func getDistanceFromSearchLocation(_ location: CLLocation) -> Double{
        location.distance(from: search.pickupLocation?.location ?? CLLocation(latitude: 0, longitude: 0))
    }
}

#Preview {
    struct PreviewVehicleSearch: View {
        @StateObject var state = RentSearchViewModel()
        
        init() {
            state.pickupLocation = previewModel.popularPlaces[0]
        }
        
        
        var body: some View {
            AvailableVehiclesList()
                .initiateServices(of: previewModel)
                .environmentObject(state)
        }
    }
    
    return PreviewVehicleSearch()
}
