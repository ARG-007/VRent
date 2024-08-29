//
//  LocationField.swift
//  VRent
//
//  Created by Arun R G on 19/08/24.
//

import SwiftUI

struct LocationField: View {
    
    let prompt: String
    let onClick: ()->Void


    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Image(systemName: "location.magnifyingglass")
                    .imageScale(.medium)
                Text(prompt)
                    .font(.callout)
                    .bold()
                Spacer()
            }
            .foregroundStyle(.foreground.opacity(0.8))
            .padding()
        }
        .applyInnerShadowEffect(blurRadius: 2, y: 1)
    }
    
    
}

#Preview {
    LocationField(prompt: "Test") {}
}
