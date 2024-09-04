//
//  RentingNavigation.swift
//  VRent
//
//  Created by Arun R G on 13/08/24.
//

import Foundation
import SwiftUI


class NavigationManager: ObservableObject {
    @Published var currentTab: Tab = .renting
    @Published var showLogin: Bool = false
}
