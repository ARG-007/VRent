//
//  View+Extensions.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import Foundation
import SwiftUI



extension View {
    /**
     [Custom Extension]
     Sets Time Interval of UIDatePicker Object `onAppear` and reset `onDisappear`. Interval can be between 1 to 30.
     */
    func setDatePickerInterval(_ interval: Int) -> some View {
        self
            .onAppear() { UIDatePicker.appearance().minuteInterval = interval }
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
    
    /**
     [Custom Extension]
     Executes `onStart` closure when user clicks on the view, and `onEnded` after precisely '0.1' secs.
     */
    func onClick(_ onStart: @escaping ()->Void, onEnded: @escaping ()->Void) -> some View {
        self
            .onTapGesture {
                onStart()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    onEnded()
                }
            }
    }
    
    /**
     [Custom Extension]
     Overlays view with shape for appearance of an border of same shape.
     */
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
     [Custom Extension]
     Hides this view conditionally
     */
    @ViewBuilder func hidden(_ condition: Bool) -> some View {
        if(condition) {
            self.hidden()
        } else {
            self
        }
    }

}
