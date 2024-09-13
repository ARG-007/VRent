//
//  RepositryViewModifier.swift
//  VRent
//
//  Created by Arun R G on 13/09/24.
//

import Foundation
import SwiftUI

struct RepositryViewModifier: ViewModifier {
    @ObservedObject var repository: Repository
    
    
    
    func body(content: Content) -> some View {
        content
            .environmentObject(repository.placesManager)
            .environmentObject(repository.vehicleManager)
            .environmentObject(repository.userManager)
            .environmentObject(repository.favoritesManager)
            .environmentObject(repository.rentalManager)
            .environmentObject(repository.taxiManager)
    }
}


extension View {
    func initiateServices(onRepo repostiory: Repository = Repository.shared) -> some View {
        self
            .modifier(RepositryViewModifier(repository: repostiory))
    }

}
