//
//  ServiceRepository.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation
import SwiftUI

struct ServiceRepository: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(Model.shared)
            .environmentObject(ModelFavoriteService.shared)
            .environmentObject(ModelBookingService.shared)
            .environmentObject(ModelTaxiService.shared)
            .environmentObject(UserService.shared)
        
    }
}

/**
 Extension on View for Initialting services on given model
 */

extension View {
    /**
     [Custom Extension]
     Initiates Services Of Model to be used by SubViews
     */
    func initiateServices() -> some View {
        self
            .modifier(ServiceRepository())
    }
}
