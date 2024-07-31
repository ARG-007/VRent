//
//  View+Extensions.swift
//  CarHub
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
        intensity: CGFloat = 0.2,
        blurRadius: CGFloat = 2,
        xOffset: CGFloat = 0,
        yOffset: CGFloat = 2
    ) -> some View {
        self
            .background() {
                shape
                    .fill(color.opacity(intensity))
                    .shadow(color: color, radius: blurRadius, x: xOffset, y: yOffset)
                shape
                    .fill(.background)
            }
    }
}
