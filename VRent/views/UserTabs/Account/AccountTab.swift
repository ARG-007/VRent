//
//  AccountTab.swift
//  VRent
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI

struct AccountTab: View {
    @Orientation var orientation
    
    
    var body: some View {
        List {
            VStack(alignment: .center) {
                ProfilePicture()
                    .frame(height: 200)
                
                Text("Hello 007")
                    .font(.largeTitle)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
            
            Section {
                NavigationLink("Profile", value: 1)
                NavigationLink("Theme", value: 2)
                NavigationLink("Color Scheme", value: 3)
            }
            
            Section("Legals") {
                NavigationLink("Terms and Condition", value: 4)
                NavigationLink("Legal Notice", value: 5)
                NavigationLink("Policies", value: 6)
                
            }
            
            Button(role: .destructive) {
                
            } label: {
                Text("Sign Out")
            }

            
        }
    }
}

#Preview {
    AccountTab()
}

