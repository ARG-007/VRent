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
    
    @State private var edit: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfilePicture()
                    .frame(height: 200)
//                    .overlay(alignment: .bottomTrailing) {
//                        Button("", systemImage: "pencil.circle.fill") {
//                            
//                        }
//                        .font(.largeTitle)
//                        .labelsHidden()
//                        .accessibilityLabel("Change Profile Picture")
//                        
//                    }
//                
//                Button("Edit", action: {edit.toggle()})
                
                if(edit) {
                    FieldInput("Nickname", value: $nickName, fieldState: $nickNameField, validator: userService.validateNickname)
                    FieldInput("Fullname", value: $fullName, fieldState: $fullNameField, validator: userService.validateFullName)
                }
                
                Group {
                    if(!edit) {
                        Text(userService.fullName!)
                        Text(userService.nickname!)
                    }
                    
                    Text(userService.phone!)
                }
                
                
                
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
