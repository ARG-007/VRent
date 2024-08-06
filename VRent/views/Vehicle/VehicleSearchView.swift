//
//  VehicleSearchView.swift
//  VRent
//
//  Created by Arun R G on 06/08/24.
//

import SwiftUI
import CoreLocation

struct VehicleSearchView: View {
    @Binding var search: RentSearchState
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.getVehicles()){ vehicle in
                    VStack {
                        VehicleCard(vehicle: vehicle)
                        
                        HStack(alignment: .top) {
                            
                            Label(getDistance(vehicle.location), systemImage: "ruler")

                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text( search.duration.converted(to: .hours).value * vehicle.pricePerHR, format: .currency(code: "INR") )
                                Text("excluding other fees")
                                    .font(.caption2)
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                    }
                    .applyBoxShadowEffect()
                    .padding()
                }
            }
        }
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
            VehicleSearchView(search: $state)
                .environmentObject(model)
        }
    }
    
    return PreviewVehicleSearch()
}
