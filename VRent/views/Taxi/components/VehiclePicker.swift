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
                .frame(height: 130)
            
            
            //            let pickerShape = UnevenRoundedRectangle(topLeadingRadius: 10, bottomTrailingRadius: 10)
            Text(localizedCurrency(selection.standardChargePerKm)+"/km")
                .padding(.horizontal,5)
            
            
            
            Picker("Vehicle Category", selection: $selection) {
                ForEach(VehicleType.allCases) { vtype in
                    Text(vtype.rawValue)
                }
            }
            .animation(.easeIn, value: selection)
            .contentTransition(.interpolate)
            .frame(maxWidth: .infinity)
            
            //            VStack(spacing: 5) {
            //                .frame(maxWidth: .infinity, alignment: .trailing)
            //                .applyBoxShadowEffect(shape: pickerShape, blurRadius: 2.7)
            //                .mask {
            //                    GeometryReader { reader in
            //                        let offset: CGFloat = 10
            //                        
            //                        pickerShape
            //                            .frame(width: reader.size.width + offset, height: reader.size.height + offset)
            //                            .offset(x: -offset-1, y: -offset-1)
            //                            .compositingGroup()
            //                    }
            //                }
            
            
            //            }
            
            
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    @State var selection: VehicleType = .HatchBack
    
    return VehiclePicker(selection: $selection)
}
