//
//  AccountTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct AccountTab: View {
    @Orientation var orientation
    @GuestMode var guestMode
    @EnvironmentObject var userService: UserService
    @EnvironmentObject var navMan: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navMan.path) {
            List {
                VStack(alignment: .center) {
                    ProfilePicture()
                        .frame(height: 200)
                        
                    
                    Text("Hello "+(guestMode ? "Guest" : userService.nickname!))
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                
                Section {
                    if !guestMode {
                        NavigationLink("Profile") {
                            ProfilePage()
                        }                        
                    }
                    NavigationLink("Theme") {
                        ThemeChangerPage()
                    }
                }
                
                Section("Legals") {
                    NavigationLink("Terms and Condition", value: 4)
                    NavigationLink("Legal Notice", value: 5)
                    NavigationLink("Policies", value: 6)
                    
                }
                
                if guestMode {
                    Button {
                        navMan.showLogin = true
                    } label: {
                        Text("Sign In")
                    }
                 } else {
                    Button(role: .destructive) {
                        userService.logOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    AccountTab()
        .initiateServices()
}

