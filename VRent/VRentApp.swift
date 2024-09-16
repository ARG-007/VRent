//
//  VRentApp.swift
//  VRent
//
//  Created by Arun R G on 23/07/24.
//

import SwiftUI

@main
struct VRentApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var themeManager = ThemeManager()
    @StateObject var repository = Repository.shared
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .initiateServices(onRepo: repository)
                .environmentObject(themeManager)
//                .preferredColorScheme(themeManager.colorScheme)
//                .animation(.easeInOut, value: themeManager.colorScheme)
            
//            VStack {
//                Text("FHHa;lshdlkasdlhj")
//            }
        }
    }
}
