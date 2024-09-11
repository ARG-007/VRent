//
//  ProfilePicture.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct ProfilePicture: View {
    @GuestMode var guestMode
    
    var body: some View {
        Circle()
            .fill(.background)
            .overlay {
                Group {
                    if !guestMode {
                        
                        Image("Avatars/Yorha")
                            .resizable()
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                    }
                }
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            }
            .border(Circle(), style: .tint, lineWidth: 5)
            .applyBoxShadowEffect(shape: Circle(), blurRadius: 4, y: 5)
            
        
            
    }
}

#Preview {
    ProfilePicture()
}
