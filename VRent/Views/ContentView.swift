//
//  ContentView.swift
//  VRent
//
//  Created by Arun R G on 23/07/24.
//

import SwiftUI
import CoreData

enum Tab: String {
    case renting = "Renting"
    case taxi = "Taxi"
    case favorite = "Favorites"
    case bookings = "Bookings"
    case account = "Account"
    
    var tabIcon: some View {
        switch(self) {
            case .renting:
                Image(systemName: "key")
            case .taxi:
            if #available(iOS 17, *) {
                Image(systemName: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
            }
            else {
                Image(systemName: "car")
            }
            case .favorite:
                Image(systemName: "heart")
            case .bookings:
            if #available(iOS 17.0, *) {
                Image(systemName: "book.pages")
            }
            else {
                Image(systemName: "book")
            }
            case .account:
                Image(systemName: "person.crop.circle")
        }
    }
    
    var label: some View {
        Label {
            Text(self.rawValue)
        } icon: {
            self.tabIcon
        }
    }
}

struct ContentView: View {
    @StateObject var navigationManager = NavigationManager()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var body: some View {
        TabView(selection: $navigationManager.currentTab) {
            
            RentingTab()
                .tabItem { Tab.renting.label }
                .tag(Tab.renting)
            
            TaxiTab()
                .tabItem { Tab.taxi.label }
                .tag(Tab.taxi)
            
            FavoritesTab()
                .tabItem { Tab.favorite.label }
                .tag(Tab.favorite)
            
            BookingsTab()
                .tabItem { Tab.bookings.label }
                .tag(Tab.bookings)
            
            AccountTab()
                .tabItem { Tab.account.label }
                .tag(Tab.account)
            
        }
        .environmentObject(navigationManager)
        .sheet(isPresented: $navigationManager.showLogin) {
            SignInPage() {
                navigationManager.showLogin = false
            }
                .frame(maxHeight: .infinity, alignment: .top)
                .presentationDetents([.fraction(0.75)])
            
        }
        .tint(themeManager.tint)
        .backgroundStyle( colorScheme == .light ? .white : Color(uiColor: .systemGray6))
    }

    
}

#Preview {
    ContentView()
        .initiateServices()
}
