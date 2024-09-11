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
            if let window = UIApplication.shared.windows.first {
                UIView
                    .transition(
                        with: window,
                        duration:  0.25,
                        options: .transitionCrossDissolve,
                        animations: {window.overrideUserInterfaceStyle = UIUserInterfaceStyle(self.colorScheme)}
                    )
            }
           
        }
    }
}



