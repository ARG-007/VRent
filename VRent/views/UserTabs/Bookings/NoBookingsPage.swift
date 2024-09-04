//
//  NoBookingsPage.swift
//  VRent
//
//  Created by Arun R G on 03/09/24.
//

import SwiftUI

struct NoBookingsPage: View {
    let forCategory: Bookings
    @EnvironmentObject private var navMan: NavigationManager
    
    var body: some View {
        VStack {
            Text("You Haven't Booked any \(forCategory)!")
                .font(.title.bold())
                .multilineTextAlignment(.center)
            
            Button {
                navMan.currentTab = (forCategory == .Rental) ? .renting : .taxi
            } label: {
                Text("Book Now !")
                    .padding()
                    .foregroundStyle(.white)
                    .applyBoxShadowEffect(background: .tint)
            }
        }
    }
}

#Preview {
    NoBookingsPage(forCategory: .Rental)
}
