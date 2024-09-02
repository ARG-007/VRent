//
//  ProfilePicture.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct ProfilePicture: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://i.pinimg.com/originals/2a/cb/b4/2acbb4248c5fbd303a8a48065865bfa6.jpg")) { image in
            image
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .border(Circle(), style: .tint, lineWidth: 5)
                .applyBoxShadowEffect(shape: Circle(), blurRadius: 4, y: 5)
        } placeholder: {
            
        }
            
        
            
    }
}

#Preview {
    ProfilePicture()
}
