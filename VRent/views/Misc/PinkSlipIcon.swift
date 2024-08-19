//
//  PinkSlipIcon.swift
//  VRent
//
//  Created by Arun R G on 12/08/24.
//

import SwiftUI

struct PinkSlipIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "doc")
                .font(.system(size: 90, weight: .thin))
                .rotation3DEffect(
                    .degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            
            Image(systemName: "car")
                .background(.background)
                .font(.system(size: 45))
                .offset(x: 33)
        }


    }
}

#Preview {
    PinkSlipIcon()
}
