//
//  FavoriteVehicleDetails.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct FavoriteVehicleDetails: View {
    let vehicle: Vehicle
    
    var body: some View {
        VehicleDetails(vehicle: vehicle) {
            Button {
                
            } label: {
                Text("Check Availablity")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .applyInnerShadowEffect(shape:.rect(cornerRadius: 10),background: .tint)
                    .padding()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    FavoriteVehicleDetails(vehicle: previewModel.getVehicles()[0])
}
