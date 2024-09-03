//
//  ExploreTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct UserFavorites: View {
    
    @EnvironmentObject private var favoriteService: ModelFavoriteService
    
    @Orientation private var orientation
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    if(orientation == .portrait || orientation == .portraitUpsideDown || orientation == .faceUp) {
                        LazyVStack(spacing: 20) {
                            cards
                        }
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            cards
                        }
                    }
                    
                }
            }
            .animation(.easeInOut(duration: 0.1), value: favoriteService.favorites)
        }
    }
    
    var cards: some View {
        
        ForEach(favoriteService.favorites) { vehicle in
            NavigationLink {
                FavoriteVehicleDetails(vehicle: vehicle)
                    
            } label: {
                VehicleCard(for: vehicle)
                    .applyBoxShadowEffect()
                    .favoriteButtonBehaviour(.delete)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
   UserFavorites()
        .initiateServices()
}
