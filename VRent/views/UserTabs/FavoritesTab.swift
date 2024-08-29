//
//  ExploreTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct FavoritesTab: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            
            LazyVStack(spacing: 20) {
                ForEach(model.getFavorites()) { vehicle in
                    VehicleCard(for: vehicle)
                        .applyBoxShadowEffect()
                        .favoriteButtonBehaviour(.delete)
                }
                .padding(.horizontal)
                .animation(.easeInOut, value: model.favorites)
            }
        }
    }
}

#Preview {
   FavoritesTab()
        .environmentObject(previewModel)
}
