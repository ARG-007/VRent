//
//  GuestMode.swift
//  VRent
//
//  Created by Arun R G on 13/09/24.
//

import Foundation
import SwiftUI

@propertyWrapper struct GuestMode: DynamicProperty {
    @ObservedObject private var userManager = UserManager.shared
    
    var wrappedValue: Bool {
        userManager.guestMode
    }
}
