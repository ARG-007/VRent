//
//  VRentApp.swift
//  VRent
//
//  Created by Arun R G on 23/07/24.
//

import SwiftUI

@main
struct VRentApp: App {
    @Environment(\.colorScheme) var defaultColorScheme
    @StateObject var themeManager = ThemeManager()
    let model = previewModel
   
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .backgroundStyle(Color(.systemGray6))
                .environmentObject(themeManager)
                .tint(themeManager.tint)
                .preferredColorScheme(themeManager.colorScheme != nil ? themeManager.colorScheme : defaultColorScheme)
                .initiateServices()
        }
    }
}
