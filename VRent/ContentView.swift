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
    case explore = "Explore"
    case bookings = "Bookings"
    case account = "Account"
    
    var tabIcon: Image {
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
            case .explore:
                Image(systemName: "safari")
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

extension View {
    func tabBarBackground(_ visibility: Visibility) -> some View {
        if #available(iOS 16.0, *) {
            return self.toolbarBackground(visibility, for: .tabBar)
        } else {
            return self
        }
    }
}

struct ContentView: View {
    @State var currentTab: Tab = .renting
    
    var body: some View {
        TabView(selection: $currentTab) {
            RentingTab()
                .tabItem { Tab.renting.label }
                .tag(Tab.renting)
                
            TaxiTab()
                .tabItem { Tab.taxi.label }
                .tag(Tab.taxi)

            ExploreTab()
                .tabItem { Tab.explore.label }
                .tag(Tab.explore)

            BookingsTab()
                .tabItem { Tab.bookings.label }
                .tag(Tab.bookings)
            
            AccountTab()
                .tabItem { Tab.account.label }
                .tag(Tab.account)
        }
        .transition(.slide)
        .animation(.easeIn, value: currentTab)
        .tint(.orange)
    }

    
}

#Preview {
    ContentView()
}
