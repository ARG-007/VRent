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
                Spacer()
            }
            .foregroundStyle(.foreground.opacity(0.7))
            .padding()
        }
        .border(RoundedRectangle(cornerRadius: 15.0), style: .tint, lineWidth: 1.5)
    }
}

#Preview {
    LocationField(prompt: "Test") {}
}
