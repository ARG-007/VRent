//
//  VehicleDetails.swift
//  VRent
//
//  Created by Arun R G on 06/08/24.
//

import SwiftUI


struct VehicleDetails: View {
    var vehicle: Vehicle

    
    @Environment(\.colorScheme) var colorScheme
    @State var presentPriceBreakUpSheet = false
    
    
   
    var body: some View {
        VStack {
            
            carousel
            
            infoBar
            
            specs
            
        }
        
    }
    
    private var carousel: some View {
        ImageCarousel(imageURLs: vehicle.images)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .applyInnerShadowEffect(shape: .rect(cornerRadius: 25.0))
            .frame(height: 400)
    }
    
    private var infoBar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(vehicle.spec.make)
                    .font(.title3)
                    .foregroundStyle(.gray)
                (
                    Text(vehicle.spec.model)
                    + Text(" ")
                    + Text(vehicle.yearFormatted)
                )
                .font(.title)
                .fontWeight(.bold)
                
                Text("By \(vehicle.owner.name)")
                    .font(.callout)
            }
            Spacer()
            
            VStack(spacing: 10) {
                Label(
                    title: { Text(vehicle.ratings.average.formatted(.number.rounded())) },
                    icon: { Image(systemName: "star.fill").foregroundStyle(.white)}
                )
                .padding(6)
                .applyInnerShadowEffect(shape: .rect(cornerRadius: 5), background: vehicle.ratings.color, blurRadius: 2, y: 0)
                .foregroundStyle(.white)
                
                Label(
                    title: {Text(vehicle.ratings.tripsCompleted.formatted())},
                    icon: {Image(systemName: "point.forward.to.point.capsulepath.fill")}
                )
                .padding(6)
                .applyInnerShadowEffect(shape: .rect(cornerRadius: 5),background: .OffWhite, blurRadius: 2, y: 0)
                
            }
            .padding(8)
            .font(.callout)
            
        }
        .font(.title2)
        .padding()
        .foregroundStyle(.shadow(.inner(radius: 1)))
        .applyInnerShadowEffect(blurRadius: 3, y: 3)
        
    }
    
    @ViewBuilder
    private var specs: some View {
        let spec = vehicle.spec
        VStack {
            HStack{
                SpecCard(spec.transmission.rawValue, systemName: "arcade.stick")
                SpecCard(spec.capacity.formatted(.number.grouping(.never)),systemName: "chair.lounge.fill")
                SpecCard("\(localizedCurrency(vehicle.pricePerHR))/hr", systemName: "hourglass")
            }
            HStack {
                SpecCard(spec.driveTrain.rawValue, systemName: "steeringwheel")
                SpecCard(spec.fuelType.rawValue, systemName: "fuelpump")
                SpecCard(spec.type.rawValue, systemName: "car")
                
            }
        }
    }
   
    
    struct SpecCard: View {
        @Environment(\.colorScheme) var colorScheme
        let specValue: String
        let specIcon: Image
        
        var body: some View {
            VStack {
                specIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.tint)
                    .frame(height: 30)
                Text(specValue)
                    .minimumScaleFactor(0.4)
                    .scaledToFit()
                    .fontWeight(.semibold)
                    
            }
            .padding()
            .frame(maxWidth: .infinity)
            .applyInnerShadowEffect(background: (colorScheme == .light ? .white : .offBlack),intensity: 0.6, blurRadius: 2, y: 1 )
        }
        
        init(_ value: String, icon: Image) {
            self.specValue = value
            self.specIcon = icon
        }
        
        init(_ value: String, systemName: String) {
            self.specValue = value
            self.specIcon = Image(systemName: systemName)
        }
        
        
    }
    
    
    
    
    

}


#Preview {
    NavigationStack {
        VehicleDetails(vehicle: previewModel.getVehicles()[0])

    }
}

