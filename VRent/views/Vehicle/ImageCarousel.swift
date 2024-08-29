//
//  ImageCarousel.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import SwiftUI

struct ImageCarousel: View {
    
    let imageURLs: [URL]

    var body: some View {
        TabView {
            ForEach(imageURLs, id: \.self) { url in
                AsyncImage(url: url) { image in
                    Color.clear
                        .overlay {
                            image
                                .resizable()
                                .scaledToFill()
                        }
                        .clipped()
                        
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(.page/*(indexDisplayMode: .never)*/)
        .transition(.slide)
    }
}

#Preview {
    let imagesUrl = previewModel.getVehicles()[0].images
    
    return ImageCarousel(imageURLs: imagesUrl)
        .aspectRatio(3/2, contentMode: .fit)
        .clipShape(.rect(cornerRadius: 25.0))
        .padding()
}
