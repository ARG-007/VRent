//
//  VehicleCard.swift
//  VRent
//
//  Created by Arun R G on 06/08/24.
//

import SwiftUI

struct VehicleCard: View {
    let vehicle: Vehicle
    
    
    @ScaledMetric(relativeTo: .subheadline) private var topBarContentPadding = 10
    
    init(for vehicle: Vehicle) {
        self.vehicle = vehicle
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                vehicleBackground
                
                VStack(alignment: .leading) {
                    
                    topInfo
                    
                    Spacer()
                    
                    bottomInfo
//                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                    
                }
                .foregroundStyle(.white)
                .padding(10)
            }
            .clipShape(.rect(cornerRadius: 15.0))
            .aspectRatio(3/2, contentMode: .fit)
        }
    }
    
    var vehicleBackground: some View {
        ZStack {
            ImageCarousel(imageURLs: vehicle.images)
            
            LinearGradient(colors: [.clear, .black.opacity(0.2), .black], startPoint: .top, endPoint: .bottom)
                .allowsHitTesting(false)            
        }
    }
    
    var ratingCard: some View {
        HStack {
            ViewThatFits {
                Label(vehicle.ratings.average.formatted(), systemImage: "star.fill")
                
                VStack {
                    Image(systemName: "star.fill")
                    Text(vehicle.ratings.average.formatted())
                }
            }
                
                .padding(topBarContentPadding/2)
                .background() {
                    RoundedRectangle(cornerRadius: 6)
                        .fill (vehicle.ratings.color)
                }
            
            (Text(vehicle.ratings.tripsCompleted, format: .number) + Text(" Trips"))
                .foregroundStyle(.foreground)

        }
        .fontWeight(.semibold)
        .padding(topBarContentPadding/2)
        .background(.background.opacity(0.8), in: .rect(cornerRadius: 6))
    }
    
    var topInfo: some View {
        HStack {
            
            ratingCard
            
            Spacer()
            
            FavoriteButton(vehicle: vehicle)
                .controlSize(.large)
                .foregroundStyle(.foreground)
                .font(.subheadline)
                .padding(topBarContentPadding)
                .background(.background.opacity(0.4), in: .rect(cornerRadius: 6))

        }
        .font(.caption)
    }
    
    var bottomInfo: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                let spec = vehicle.spec
                
                Text(spec.make)
                    .font(.callout)
                HStack {
                    Text(spec.model)
                    Text(spec.year, format: .number.grouping(.never))
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                Text("\(spec.transmission) | \(spec.fuelType) | \(spec.capacity) Seats")
                    .font(.caption)
                
                
//                HStack{
//                    Text(spec.transmission.rawValue)
//                    Text("|")
//                    Text(spec.fuelType.rawValue)
//                    Text("|")
//                    Text(spec.capacity, format: .number) + Text(" Seats")
//                }
//                .font(.subheadline)
            }
            Spacer()
            
            Text("\(localizedCurrency(vehicle.pricePerHR))/hr")
                
        }
    }
}


#Preview {
    VehicleCard(for: VehicleManager.shared.getVehicles()[0])
}
