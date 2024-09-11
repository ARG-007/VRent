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
    
    @Namespace var profileHeroSpace
    
    @StateObject var nav = Navigation()
    
    @State private var profilePagePresented = false
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            List {
                
                profilePicture
                
                appSettings
                
                legals
                
                accountAction
                
            }
            .navigationDestination(isPresented: $profilePagePresented) {
                ProfilePage(profileNameSpace: profileHeroSpace)
            }
        }
    }

    var profilePicture: some View {
        VStack(alignment: .center) {
//            Group {
//                if(profilePagePresented) {
//                    ProfilePicture()
//                        .matchedGeometryEffect(id: "profilePic", in: profileHeroSpace)
//                } else {
//                    ProfilePicture()
//                }
//                    
//            }
            ProfilePicture()
                .matchedGeometryEffect(id: "profilePic", in: profileHeroSpace)
                .frame(height: 200)
                .animation(.easeIn, value: profilePagePresented)
                
            
            Text("Hello "+(guestMode ? "Guest" : userService.nickname!))
                .font(.largeTitle)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .listRowBackground(Color(uiColor: .systemGroupedBackground))
    }
    
    var appSettings: some View {
        Section {
            if !guestMode {
                Button {
                    profilePagePresented.toggle()
                } label: {
                    Text("Profile")
                }
            }

            ThemeChangerPage()
                .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading]}
            
            ColorSchemeChangePage()
        }
    }
    
    var legals: some View {
        Section("Legals") {
            NavigationLink("Terms and Condition") {
                TermsAndConditionPage()
            }
            NavigationLink("Legal Notice") {
                PoliciesPage()
            }
            NavigationLink("Policies") {
                LegalNoticePage()
            }
            
        }
    }
    
    
    var accountAction: Button<Text> {
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

#Preview {
    AccountTab()
        .initiateServices()
}

