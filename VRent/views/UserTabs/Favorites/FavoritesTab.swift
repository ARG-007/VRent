//
//  ExploreTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct FavoritesTab: View {
    
    @EnvironmentObject var favoriteService: ModelFavoriteService
    @Orientation var orientation
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
            ScrollView {
                if(orientation == .portrait || orientation == .portraitUpsideDown) {
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
            .animation(.easeInOut, value: favoriteService.favorites)
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
   FavoritesTab()
        .initiateServices(of: previewModel)
}
