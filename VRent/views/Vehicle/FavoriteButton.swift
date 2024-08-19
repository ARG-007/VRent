//
//  FavoriteButton.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject var model: Model
    let vehicle: Vehicle
    @State private var isFavorite: Bool
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        self.isFavorite = false
    }
    
    var body: some View {
        Button {
            isFavorite ? model.unFavorite(vehicle: vehicle) : model.favorite(vehicle: vehicle)
            isFavorite = model.hadFavorited(vehicle: vehicle)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? AnyShapeStyle(.pink) : AnyShapeStyle(.foreground))
                .imageScale(.large)
        }
        .onAppear {isFavorite = model.hadFavorited(vehicle: vehicle) }
        .controlSize(.large)
    }
}

