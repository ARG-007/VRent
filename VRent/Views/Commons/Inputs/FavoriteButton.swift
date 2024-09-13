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
    Make `FavoriteButton` present an Dustbin Symbol and exposes only untoggle behaviour. The button disables itself if the vehicle is already not an favorite.
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
    @EnvironmentObject var navMan: NavigationManager
    @EnvironmentObject var favoriteService: FavoritesManager
    @Environment(\.favoriteButtonBehaviour) var behaviour
    
    @GuestMode var guestMode
    
    let vehicle: Vehicle
    @State private var isFavorite = false
    
    var body: some View {
        
        appropriateButton
            .buttonStyle(PlainButtonStyle())
            .controlSize(.large)
            .onAppear { isFavorite = favoriteService.isFavorite(vehicle) }
    }
    
    var toggleFavoriteButton: some View {
        Button (action: toggleFavorite) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle( isFavorite ? AnyShapeStyle(.pink) : AnyShapeStyle(.primary))
        }
            
    }
    
    var deleteButton: some View {
        Button(action: toggleFavorite) {
            Image(systemName: "xmark")
                .foregroundStyle(.primary)
        }
        .disabled(!isFavorite)
            
    }
    
    @ViewBuilder var appropriateButton: some View {
        if(behaviour == .toggle ) {
            toggleFavoriteButton
        } else {
            deleteButton
        }
    }
    
    private func toggleFavorite() {
        if(guestMode) {
            navMan.showLogin = true
            return
        }
        isFavorite = favoriteService.toggleFavorite(for: vehicle)
        
    }
    
}

#Preview {
    @State var favorite = VehicleManager.shared.getVehicles()[0]
//    @StateObject var model = previewModel
    
    HStack {
        FavoriteButton(vehicle: favorite)
            
        
        FavoriteButton(vehicle: favorite)
            .favoriteButtonBehaviour(.delete)
    }
    .foregroundStyle(.foreground)
    .initiateServices()
}
