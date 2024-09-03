//
//  ProfilePage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct ProfilePage: View {
    
    @EnvironmentObject var userService: UserService
    
    @State private var nickName: String = ""
    @State private var fullName: String = ""
    
    
    @State private var nickNameField: FieldState = .unset
    @State private var fullNameField: FieldState = .unset
    
    @State private var showErrors: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProfilePicture()
                    .frame(height: 200)
                    .overlay(alignment: .bottomTrailing) {
                        Button("", systemImage: "pencil.circle.fill") {
                            
                        }
                        .font(.largeTitle)
                        .labelsHidden()
                        .accessibilityLabel("Change Profile Picture")
                        
                    }
                
                
                
                TextField("Nickname", text: $nickName)
                    .textContentType(.nickname)
                
                TextField("Full Name", text: $fullName)
                    .textContentType(.givenName)
                
                
                Text(userService.phone ?? "")
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        
        
        
    }
    
}

#Preview {
    ProfilePage()
        .initiateServices()
}
