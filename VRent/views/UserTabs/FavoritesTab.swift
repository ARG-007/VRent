//
//  ExploreTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct FavoritesTab: View {
    @EnvironmentObject var favoriteService: ModelFavoriteService
    
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(favoriteService.favorites) { vehicle in
                    VehicleCard(for: vehicle)
                        .applyBoxShadowEffect()
                        .favoriteButtonBehaviour(.delete)
                }
                .padding(.horizontal)
            }
        }
        .animation(.easeInOut, value: favoriteService.favorites)
    }
}

#Preview {
   FavoritesTab()
        .initiateServices(of: previewModel)
}
