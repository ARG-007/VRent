//
//  BottomStickyArea.swift
//  VRent
//
//  Created by Arun R G on 01/09/24.
//

import SwiftUI

struct BottomStickyArea<Child: View>: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme

    let content: () -> Child
    
    private let shape: UnevenRoundedRectangle
    
    
    init(cornerRadius: CGFloat, @ViewBuilder content: @escaping () -> Child) {
        self.content = content
    
        shape = .rect(topLeadingRadius: cornerRadius, topTrailingRadius: cornerRadius)
        
    }
    
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                self.content()
                    .background {
                       shape
                            .fill(.background)
                            .ignoresSafeArea(edges: .bottom)
                            .applyBoxShadowEffect(shape: shape, y: -1)
                        
                    }
            }
    }
}

extension View {
    func bottomSticky(cornerRadius: CGFloat, @ViewBuilder child: @escaping ()->some View) -> some View{
        self
            .modifier(BottomStickyArea(cornerRadius: cornerRadius, content: child))
    }
}

