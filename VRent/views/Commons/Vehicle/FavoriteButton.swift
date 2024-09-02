//
//  FavoriteButton.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import SwiftUI

/**
 Impacts the favorite button behaviour and appearence
 */
enum FavoriteButtonBehaviour {
    
    /**
    Make `FavoriteButton` present an Heart Toggle, with fill
     */
    case toggle
    
    /**
    Make `FavoriteButton` present an Dustbin Symbol and exposes only untoggle behaviour. The button hides itself if the vehicle is already not an favorite.
     */
    case delete
}

/**
 Environment Key for Favorite Button Behaviour
 */
struct FavoriteButtonBehaviourKey: EnvironmentKey {
    static var defaultValue: FavoriteButtonBehaviour = .toggle
}

extension EnvironmentValues {
    var favoriteButtonBehaviour: FavoriteButtonBehaviour {
        get {self[FavoriteButtonBehaviourKey.self]}
        set {self[FavoriteButtonBehaviourKey.self] = newValue}
    }
}

extension View {
    func favoriteButtonBehaviour(_ newBehaviour: FavoriteButtonBehaviour) -> some View {
        return self
            .environment(\.favoriteButtonBehaviour, newBehaviour)
    }
}

struct FavoriteButton: View {
    @EnvironmentObject var favoriteService: ModelFavoriteService
    @Environment(\.favoriteButtonBehaviour) var behaviour
    
    let vehicle: Vehicle
    @State private var isFavorite = false
    
    var body: some View {
        
        Button (action: toggleFavorite) {
            if(behaviour == .toggle ) {
                toggleFavoriteButton
            } else {
                deleteButton
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear { isFavorite = favoriteService.isFavorite(vehicle) }
    }
    
    var toggleFavoriteButton: some View {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
            .foregroundStyle( isFavorite ? AnyShapeStyle(.pink) : AnyShapeStyle(.primary))
            
    }
    
    @ViewBuilder var deleteButton: some View {
        Button(action: toggleFavorite) {
            if (isFavorite) {
                Image(systemName: "xmark")
                    .foregroundStyle(.primary)
            } else {
                EmptyView()
            }
        }
            
    }
    
    private func toggleFavorite() {
        isFavorite = favoriteService.toggleFavorite(for: vehicle)
    }
    
    private func readFavorite() {
        isFavorite = favoriteService.isFavorite(vehicle)
    }
    
}

#Preview {
    @State var favorite = previewModel.favorites[0]
//    @StateObject var model = previewModel
    
    return HStack {
        FavoriteButton(vehicle: favorite)
            
        
        FavoriteButton(vehicle: favorite)
            .favoriteButtonBehaviour(.delete)
    }
    .foregroundStyle(.foreground)
    .initiateServices(of: previewModel)
}
