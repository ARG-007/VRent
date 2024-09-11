//
//  NoFavoritesPage.swift
//  VRent
//
//  Created by Arun R G on 03/09/24.
//

import SwiftUI

struct NoFavoritesPage: View {
    var body: some View {
        Text("You Haven't Favorited Any Vehicle!")
            .font(.title.bold())
            .multilineTextAlignment(.center)
    }
}

#Preview {
    NoFavoritesPage()
}
