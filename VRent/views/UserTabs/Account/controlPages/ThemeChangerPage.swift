//
//  ThemeChangerPage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct ThemeChangerPage: View {
    @EnvironmentObject private var themeMan: ThemeManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("Theme")
                .bold()
            
            HStack(spacing: 20) {
                ForEach(Color.appTints, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(height: 28)
                        .border(.circle, style: (color==themeMan.tint) ? AnyShapeStyle(.foreground) : AnyShapeStyle(.clear), lineWidth: 3)
                        .onTapGesture {
                            themeMan.tint = color
                        }
                }
            }
            .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity)

    }
}

#Preview {
    ThemeChangerPage()
}
