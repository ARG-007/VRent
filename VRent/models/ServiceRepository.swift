//
//  ServiceRepository.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation
import SwiftUI

struct ServiceRepository: ViewModifier {
    private let model: Model
    
    let favoriteService: ModelFavoriteService
    
    
    init(with model: Model) {
        self.model = model
        favoriteService = ModelFavoriteService(model)
    }
    
    func body(content: Content) -> some View {
        content
            .environmentObject(model)
            .environmentObject(favoriteService)
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
    func initiateServices(of model: Model) -> some View {
        self
            .modifier(ServiceRepository(with: model))
    }
}
