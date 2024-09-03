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
                        AsyncImage(url: URL(string: "https://i.pinimg.com/originals/2a/cb/b4/2acbb4248c5fbd303a8a48065865bfa6.jpg")) { image in
                            
                            image
                                .resizable()
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                    }
                }
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
            }
            .border(Circle(), style: .tint, lineWidth: 5)
            .applyBoxShadowEffect(shape: Circle(), blurRadius: 4, y: 5)
            
        
            
    }
}

#Preview {
    ProfilePicture()
}
