//
//  SignInRequestPage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI

struct SignInRequestPage: View {
    @EnvironmentObject private var navMan: NavigationManager
    var body: some View {
        VStack {
            Text("Sign In To View This Page")
                .font(.title3.bold())
                
            
            Button {
                navMan.showLogin = true
            } label: {
                Text("Sign In")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .padding()
                    .applyBoxShadowEffect(background: .tint)
            }
        }
    }
}
