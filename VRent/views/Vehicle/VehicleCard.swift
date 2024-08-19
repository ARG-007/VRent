//
//  VehicleCard.swift
//  VRent
//
//  Created by Arun R G on 06/08/24.
//

import SwiftUI

struct VehicleCard: View {
    let vehicle: Vehicle
    @State var isFavirote: Bool = false
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                
                vehicleBackground
                
                VStack(alignment: .leading) {
                    
                    topInfo
                    
                    Spacer()
                    
                    bottomInfo
                    
                    
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
            Label(vehicle.ratings.average.formatted(), systemImage: "star.fill")
                .padding(6)
                .background() {
                    RoundedRectangle(cornerRadius: 6)
                        .fill (vehicle.ratings.color)
                }
            
            (Text(vehicle.ratings.tripsCompleted, format: .number) + Text(" Trips"))
                .foregroundStyle(.foreground)

        }
        .fontWeight(.semibold)
        .padding(4)
        .background(in: .rect(cornerRadius: 6))
    }
    
    var topInfo: some View {
        HStack {
            
            ratingCard
                .font(.caption)
            
            Spacer()
            
            FavoriteButton(vehicle: vehicle)
            
        }
    }
    
    var bottomInfo: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                
                
                Text(vehicle.spec.make)
                    .font(.callout)
                HStack {
                    Text(vehicle.spec.model)
                    Text(vehicle.spec.year, format: .number.grouping(.never))
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                HStack{
                    Text(vehicle.spec.transmission.rawValue)
                    Text("|")
                    Text(vehicle.spec.fuelType.rawValue)
                    Text("|")
                    Text(vehicle.spec.capacity, format: .number) + Text(" Seats")
                }
                .font(.subheadline)
            }
            Spacer()
            
            Text("\(localizedCurrency(vehicle.pricePerHR))/hr")
                
        }
    }
}


#Preview {
    let model = Model()
    let vehicle = model.getVehicles()[0]
    
    return VehicleCard(vehicle: vehicle)
}
