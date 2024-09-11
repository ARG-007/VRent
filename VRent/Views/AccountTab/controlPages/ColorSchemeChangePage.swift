//
//  ColorSchemeChangePage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct ColorSchemeChangePage: View {
    @EnvironmentObject private var themeMan: ThemeManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("Color Scheme")
                .bold()
            Picker(selection: $themeMan.colorScheme) {
                Text("System")
                    .tag(nil as ColorScheme?)
                Text("Light")
                    .tag(ColorScheme.light)
                Text("Dark")
                    .tag(ColorScheme.dark)
            } label: {
                Text("Color Scheme")
            }
            .pickerStyle(.segmented)

        }
    }
}

#Preview {
    ColorSchemeChangePage()
}
