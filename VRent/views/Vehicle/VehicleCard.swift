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
    
    var ratingCard: some View {
        HStack {
            Label(vehicle.ratings.formatted(), systemImage: "star.fill")
                .padding(6)
                .background() {
                    RoundedRectangle(cornerRadius: 6)
                        .fill (getRatingColor())
                }
            
            (Text(vehicle.tripsCompleted, format: .number) + Text(" Trips"))
                .foregroundStyle(.foreground)

        }
        .fontWeight(.semibold)
        .padding(4)
        .background(in: .rect(cornerRadius: 6))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                ImageCarousel(imageURLs: vehicle.images)
                
                LinearGradient(colors: [.clear, .black.opacity(0.2), .black], startPoint: .top, endPoint: .bottom)
                    .allowsHitTesting(false)
                
                
                VStack(alignment: .leading) {
                    HStack {
                        ratingCard
                            .font(.caption)
                        Spacer()
                        
                        Button {
                            isFavirote.toggle()
                        } label: {
                            Image(systemName: isFavirote ? "heart.fill" : "heart")
                                .foregroundStyle(isFavirote ? .pink : .white)
                                .imageScale(.large)
                        }
                        
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            
                            
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
                        }
                        Spacer()
                        
                        Text(vehicle.pricePerHR, format: .currency(code: Locale.current.currency?.identifier ?? "INR")) + Text("/hr")
                            
                    }
                    
                    
                    
                }
                .foregroundStyle(.white)
                .padding(10)
            }
            .clipShape(.rect(cornerRadius: 15.0))
            .aspectRatio(3/2, contentMode: .fit)
        }
    }
    
}


// MARK - Helpers
 fileprivate extension VehicleCard {
     func getRatingColor() -> Color {
         switch(vehicle.ratings) {
            case 0...2.5 : .red
            case 2.5...3.5: .orange
            default: .green
         }
     }
}

#Preview {
    let model = Model()
    let vehicle = model.getVehicles()[0]
    
    return VehicleCard(vehicle: vehicle)
}
