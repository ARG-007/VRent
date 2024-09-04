//
//  ThemeManager.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var tint: Color = .appTints[0]
    @Published var colorScheme: ColorScheme? = nil {
        didSet {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIUserInterfaceStyle(colorScheme)
        }
    }
}

extension Color {
    
}


