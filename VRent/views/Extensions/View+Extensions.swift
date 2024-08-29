//
//  View+Extensions.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var OffWhite: Color { Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255) }
    static var offBlack: Color { Color(red: 0.1, green: 0.1, blue: 0.2) }
}

extension View {
    func setDatePickerInterval(_ interval: Int) -> some View {
        self
            .onAppear() { UIDatePicker.appearance().minuteInterval = 30 }
            .onDisappear() { UIDatePicker.appearance().minuteInterval = 1 }
    }
    
    func applyBoxShadowEffect(
        shape: some Shape = .rect(cornerRadius: 15.0),
        background: some ShapeStyle = .background,
        color: Color = .black,
        intensity: CGFloat = 0.33,
        blurRadius: CGFloat = 3,
        x: CGFloat = 0,
        y: CGFloat = 2
    ) -> some View {
        self
            .background() {
                if #available(iOS 16.0, *) {
                    shape
                    .fill(background.shadow(
                        .drop(
                            color: color.opacity(intensity),
                            radius: blurRadius,
                            x: x,
                            y: y
                        ))
                    )
                } else {
                    shape
                        .fill(color.opacity(intensity))
                        .shadow(color: color, radius: blurRadius, x: x, y: y)
                    shape
                        .fill(background)
                }
                
                
            }
    }
    
    func applyInnerShadowEffect(
        shape: some Shape = .rect(cornerRadius: 15.0),
        background: some ShapeStyle = .background,
        color: Color = .black,
        intensity: CGFloat = 0.33,
        blurRadius: CGFloat = 3,
        x: CGFloat = 0,
        y: CGFloat = 2
    ) -> some View {
        return self
            .background() {
                shape
                    .fill(background.shadow(
                        .inner(
                            color: color.opacity(intensity),
                            radius: blurRadius,
                            x: x,
                            y: y
                        ))
                    )
            }
            
        
        
    }
    
    func onClick(_ onStart: @escaping ()->Void, onEnded: @escaping ()->Void) -> some View {
        self
            .onTapGesture {
                onStart()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    onEnded()
                }
            }
    }
    
    func border(
        _ shape: some InsettableShape,
        style: some ShapeStyle,
        lineWidth: CGFloat = 1
    ) -> some View {
        self
            .overlay{
                shape
                    .strokeBorder(style, lineWidth: lineWidth)
            }
    }
    
    
    /**
     `Custom Extension`: Hides this view conditionally
     */
    @ViewBuilder func hidden(_ condition: Bool) -> some View {
        if(condition) {
            self.hidden()
        } else {
            self
        }
    }

}
