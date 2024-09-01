//
//  VRentApp.swift
//  VRent
//
//  Created by Arun R G on 23/07/24.
//

import SwiftUI

@main
struct VRentApp: App {
    let model = previewModel
   
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .backgroundStyle(Color(.systemGray6))
                .initiateServices(of: previewModel)
        }
    }
}
