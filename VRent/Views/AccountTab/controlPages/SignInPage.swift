//
//  SignInPage.swift
//  VRent
//
//  Created by Arun R G on 03/09/24.
//

import SwiftUI
import Combine

struct SignInPage: View {
    @EnvironmentObject var userService: UserManager
    
    static private let signInError = "User Do Not Exists, Check and Reenter Phone Number, or Sign Up Instead"
    static private let signUpError = "User Already Exists, Sign In Instead"
    
    @State private var fullName: String = ""
    @State private var nickName: String = ""
    @State private var phone: String = ""

    
    @State private var nickNameFieldState: FieldState = .unset
    @State private var fullNameFieldState: FieldState = .unset
    @State private var phoneFieldState: FieldState = .unset
    
    @State private var signUp: Bool = false {
        willSet {
            if(newValue == signUp) { return }
            
            if(phoneFieldState == .invalid(SignInPage.signInError) || phoneFieldState == .invalid(SignInPage.signUpError)) {
                phoneFieldState = .valid
            }
        }
    }
    @State private var showErrors: Bool = false
    
    
    let onSignInSuccess: () -> Void

    
    var body: some View {
        VStack(spacing: 10) {
            
            Text(modeText)
                .bold()
                .font(.title)
                .padding(.bottom)
                .contentTransition(.interpolate)
            
            phoneField
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .onReceive(Just(phone)) { _ in
                    phone = String(phone.prefix(10))
                }
            
            
            if (signUp) {
                nicknameField
                
                fullnameField
                    .keyboardType(.asciiCapable)
            }
            
            Button(action: authenticate) {
                signUpLabel
            }
            .padding()
            .padding(.top)
            .animation(.snappy, value: signUp)
            
            Button("\(signUp ? "Sign In" : "Sign Up" ) Instead", action: {signUp.toggle()})
                .padding(.bottom)
            
        }
        .padding()
        .animation(.easeOut, value: signUp)
    }
    
    var modeText: String {
        signUp ? "Sign Up" : "Sign In"
    }
    
    var signUpLabel: some View {
        Text(signUp ? "Sign Up" : "Sign In")
            .font(.headline)
            .bold()
            .foregroundStyle(.white)
            .frame(minWidth: 70 ,maxWidth: .infinity)
            .padding()
            .applyBoxShadowEffect(shape: .rect(cornerRadius: 15), background: .tint)
    }
    
    
    
    
    var nicknameField: some View {
        FieldInput("Enter your Nickname", value: $nickName, fieldState: $nickNameFieldState, validator: userService.validateNickname)
            
    }
    
    var fullnameField: some View {
        FieldInput("Enter your Fullname", value: $fullName, fieldState: $fullNameFieldState, validator: userService.validateFullName)
    }
    
    var phoneField: some View {
        FieldInput("Enter your Phone", value: $phone, fieldState: $phoneFieldState, validator: userService.validatePhone)
    }
    
    private func authenticate() {
        if(signUp) {
            signUpUser()
        } else {
            signInUser()
        }
    }
    
    private func signInUser() {
        phoneFieldState = userService.validatePhone(phone)
        
        guard phoneFieldState.isValid else { return }
        
        if(userService.login(phone: phone)) {
            onSignInSuccess()
        } else {
            phoneFieldState = .invalid(SignInPage.signInError)
        }
    }
    
    private func signUpUser() {
        phoneFieldState = userService.validatePhone(phone)
        fullNameFieldState = userService.validateFullName(fullName)
        nickNameFieldState = userService.validateNickname(nickName)
        
        guard phoneFieldState.isValid
                && fullNameFieldState.isValid
                && nickNameFieldState.isValid else { return }
        
        if(userService.signup(fullName: fullName, nickName: nickName, phone: phone)) {
            onSignInSuccess()
        } else {
            phoneFieldState = .invalid(SignInPage.signUpError)
        }
    }
    
    
    
}

struct FieldInput: View {
    let prompt: String
    @Binding var value: String
    @Binding var fieldState: FieldState
    let validator: (String) -> FieldState
    
    init(_ prompt: String, value: Binding<String>, fieldState: Binding<FieldState>, validator: @escaping (String) -> FieldState) {
        self.prompt = prompt
        self._value = value
        self._fieldState = fieldState
        self.validator = validator
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TextField(prompt, text: $value)
                .onChange(of: value) { newValue in
                    fieldState = validator(newValue)
                }
                .padding()
                .applyBoxShadowEffect(color: (fieldState == .valid || fieldState == .unset) ? .black : .red)
            
            Text(fieldState.errorString)
                .font(.callout)
                .padding(.leading)
                .foregroundStyle(.red)
                .bold()
            
        }
    }
}

#Preview {
    SignInPage() {}
        .initiateServices()
}
