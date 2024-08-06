//
//  View+Extensions.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import Foundation
import SwiftUI

extension View {
    func setDatePickerInterval(_ interval: Int) -> some View {
        self
            .onAppear() { UIDatePicker.appearance().minuteInterval = 30 }
            .onDisappear() { UIDatePicker.appearance().minuteInterval = 1 }
    }
    
    func applyBoxShadowEffect(
        shape: some Shape = RoundedRectangle(cornerRadius: 15.0),
        color: Color = .black,
        intensity: CGFloat = 0.5,
        blurRadius: CGFloat = 3,
        xOffset: CGFloat = 0,
        yOffset: CGFloat = 2
    ) -> some View {
        self
            .background() {
                if #available(iOS 16.0, *) {
                    shape
                        .fill(
                            .background
                                .shadow(.drop(
                                    color: color.opacity(intensity),
                                    radius: blurRadius,
                                    x: xOffset,
                                    y: yOffset)
                                ))
                } else {
                    shape
                        .fill(color.opacity(intensity))
                        .shadow(color: color, radius: blurRadius, x: xOffset, y: yOffset)
                    shape
                        .fill(.background)
                }
                
                
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
}
