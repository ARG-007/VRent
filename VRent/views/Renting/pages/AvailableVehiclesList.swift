//
//  AvailableVehiclesList.swift
//  VRent
//
//  Created by Arun R G on 06/08/24.
//

import SwiftUI
import CoreLocation

struct AvailableVehiclesList: View {
    @Binding var search: RentSearchState
    @EnvironmentObject var model: Model
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.getVehicles()){ vehicle in
                    NavigationLink {
                        RentingVehicleDetails(rentDetails: search.getRentSearchQuery(), vehicle: vehicle)
                    } label: {
                        createVehicleCard(for: vehicle)
                    }

                }
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationTitle("Available Cars")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func createVehicleCard(for vehicle: Vehicle) -> some View {
        VStack(spacing: 0) {
            VehicleCard(vehicle: vehicle)
            
            
            HStack(alignment: .top) {
                
                Label(getDistance(vehicle.location), systemImage: "ruler")
                
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
        .applyBoxShadowEffect(background: (colorScheme == .light ? .white : .offBlack))
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
        let model = Model()
        @State var state = RentSearchState()
        
        init() {
            state.pickupLocation = model.popularPlaces[0]
        }
        
        
        var body: some View {
            AvailableVehiclesList(search: $state)
                .environmentObject(model)
        }
    }
    
    return PreviewVehicleSearch()
}
