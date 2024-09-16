//
//  VehiclePicker.swift
//  VRent
//
//  Created by Arun R G on 01/09/24.
//

import SwiftUI

struct VehiclePicker: View {
    @Binding var selection: VehicleType
    
    var body: some View {
    
        VStack {
            selection.image
                .resizable()
                .scaledToFit()
                .aspectRatio(3/2, contentMode: .fit)
                .id(selection)
                .frame(height: 130)
            
            
            Text(localizedCurrency(selection.standardChargePerKm)+"/km")
                .contentTransition(.numericText())
                .padding(.horizontal,5)

            Picker(selection: $selection) {
                ForEach(VehicleType.allCases) { vtype in
                    Text(vtype.rawValue)
                }
            } label: {
                Text(selection.rawValue)
            }
//            .border(Color.mint)
//            .frame(maxWidth: .infinity)
//            .border(Color.pink)
            .animation(.easeIn, value: selection)
            .contentTransition(.interpolate)
        }
        .frame(maxWidth: .infinity)
        .animation(.spring, value: selection)
        
    }
}

#Preview {
    @State var selection: VehicleType = .HatchBack
    
    return VehiclePicker(selection: $selection)
}
