//
//  SlidingButton.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import SwiftUI

struct SwipeControl: View {
    let prompt: String
    let onSubmit: ()->Void
    
    let thumbWidth = 70.0
    
    @State private var thumbState: CGFloat = .zero

    init(prompt: String, onSubmit: @escaping () -> Void) {
        self.prompt = prompt
        self.onSubmit = onSubmit
    }
    
    
    var body: some View {
        VStack {
            track
                .overlay {
                    GeometryReader { proxy in
                        let maxOffset = proxy.size.width - thumbWidth
                        
                        thumb
                            .offset(x: thumbState)
                            .gesture(
                                DragGesture(coordinateSpace: .local)
                                    .onChanged{ pos in
                                        
                                        var x = pos.location.x
                                        
                                        
                                        if(x < 0) { return }
                                        
                                        if(x >= maxOffset) {
                                            // onSubmit()
                                            x = maxOffset
                                        }
                                       
                                        thumbState = x
                                        
                                    }
                                    .onEnded { pos in
                                        if(pos.location.x >= maxOffset) {
                                            onSubmit()
                                        } else {
                                            withAnimation(.spring) {
                                                thumbState = .zero
                                            }
                                        }
                                    }
                            )
                    }
                    .padding(5)
                    
                }
        }
        
    }
    var track: some View {
        ZStack {
            Capsule()
                .fill(.tint.shadow(.inner(radius: 2, y: 3)))
                .frame(height: 60)
            Text(prompt)
                .foregroundColor(.white)
                .bold()
                .font(.title2)
        }
    }
    
    var thumb: some View {
        Capsule()
        .fill(.white.shadow(.drop(radius: 2, y: 3)))
        .frame(width: thumbWidth)
            
    }
    
}

#Preview {
    SwipeControl(prompt: "Test", onSubmit: {Alert(title: Text("Hey"))})
        .padding()
}
