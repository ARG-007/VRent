//
//  SuccessScreen.swift
//  VRent
//
//  Created by Arun R G on 12/08/24.
//

import SwiftUI

struct PinkSlipMarkerIcon: View {

    var body: some View {
        ZStack {
            Group {
                Image(systemName: "square")
                    .font(.system(size: 200).weight(.ultraLight))
                    
                Image(systemName: "square")
                    .font(.system(size: 170).weight(.light))
            }
            .rotationEffect(.degrees(45))
            
//            PinkSlipIcon()
//                .offset(x: -15, y: -5)
            
//            Image(systemName: "questionmark")
//                .font(.system(size: 90))
            
            Image(systemName: "xmark")
                .font(.system(size: 90))
        }
    }
}

#Preview {
    PinkSlipMarkerIcon()
}
