//
//  ThemeChangerPage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct ThemeChangerPage: View {
    @EnvironmentObject private var themeMan: ThemeManager
    
    @Namespace private var themeRing
    
    private var animateSelection = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Theme")
                .bold()
            
            HStack(spacing: 20) {
                ForEach(Color.appTints, id: \.self) { color in
                    applySelectionAppearence(isSelected: color == themeMan.tint) {
                        Circle()
                            .fill(color)
                            .frame(width: 28, height: 28)
                            .onTapGesture {
                                withAnimation(.smooth) {
                                    themeMan.tint = color
                                }
                            }
                    }
                        
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .frame(maxWidth: .infinity)
        .animation(.bouncy, value: themeMan.tint)
        
    }
    
    @ViewBuilder private func applySelectionAppearence(isSelected: Bool, item: () -> some View) -> some View {
        if animateSelection {
            item()
                .padding(2)
                .background() {
                    if isSelected {
                        Circle()
                            .fill(.foreground.opacity(0.3))
                            .matchedGeometryEffect(id: "SelectedTheme", in: themeRing, anchor: .center)
                    }
                }
        } else {
            // This has reliable appearance albiet being bland
            item()
                .border(.circle, style: isSelected ? AnyShapeStyle(.foreground) : AnyShapeStyle(.clear), lineWidth: 3)
        }
    }
}

#Preview {
    ThemeChangerPage()
}
