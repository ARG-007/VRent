//
//  VehicleView.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import SwiftUI

struct VehicleBackground: View {
    @EnvironmentObject var model: Model
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.getVehicles()) { vehicle in
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(vehicle.images, id: \.self) { image in
                                AsyncImage(url: image) { result in
                                    result.image?
                                        .resizable()
                                        .scaledToFill()
                                }
                                .frame(height: 200)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VehicleBackground()
        .environmentObject(Model())
}
