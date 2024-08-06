//
//  VRentApp.swift
//  VRent
//
//  Created by Arun R G on 23/07/24.
//

import SwiftUI

@main
struct VRentApp: App {
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
        }
    }
}
