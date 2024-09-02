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
            Text("Some JKNHSAKJH")
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    FavoriteVehicleDetails(vehicle: previewModel.getVehicles()[0])
}
