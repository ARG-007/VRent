//
//  ExploreTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct UserFavorites: View {
    
    @EnvironmentObject private var favoriteService: FavoritesManager
    
    @Orientation private var orientation
    
    @State private var modelSearch = ""
    
    var body: some View {
        NavigationStack {
            Group {
                let _ = print("User Favorites View: Rendering")
                if(favoriteService.getFavoritesCount() > 0) {
                    ScrollView {
                        if(orientation.isLandscape) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                cards
                            }
                        } else {
                            LazyVStack(spacing: 20) {
                                cards
                            }
                        }
                        
                    }
                    .searchable(text: $modelSearch,placement: .navigationBarDrawer, prompt: Text("Search by Vehicle Model"))
                    
                } else {
                    NoFavoritesPage()
                }
            }
            .animation(.easeInOut(duration: 0.1), value: favoriteService.favorites)
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder var cards: some View {
        let _ = print(" ------- Favorites View: Rendering Favorited Vehicles -------")
        ForEach(vehicles) { vehicle in
            NavigationLink {
                FavoriteVehicleDetails(vehicle: vehicle)
                
            } label: {
                VehicleCard(for: vehicle)
                    .applyBoxShadowEffect()
                    .favoriteButtonBehaviour(.delete)
                
            }
            .id(vehicle.id)
        }
        .padding(.horizontal)
        .animation(.bouncy, value: vehicles)
    }
    
    var vehicles: [Vehicle] {
        print(" ---- Favorites View: Getting Favorited Vehicles")
        
        var vehicles = favoriteService.favorites
        
        if(!modelSearch.isEmpty) {
            vehicles = vehicles.filter {
                $0.name.contains(modelSearch)
            }
        }
        
        return vehicles
        
    }
}

#Preview {
   UserFavorites()
        .initiateServices()
}
