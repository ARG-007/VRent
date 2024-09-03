//
//  RentingNavigation.swift
//  VRent
//
//  Created by Arun R G on 13/08/24.
//

import Foundation
import SwiftUI


class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    @Published var currentTab: Tab = .renting {
        willSet {
            path = NavigationPath()
        }
    }
    @Published var showLogin: Bool = true
}
