//
//  TaxiLocationSelector.swift
//  VRent
//
//  Created by Arun R G on 01/09/24.
//

import SwiftUI

struct TaxiLocationSelector: View {
    
    @Binding var pickupSelection: Location?
    @Binding var dropSelection: Location?
    
    @Binding var locationSelection: LocationSelectionTab?
    
    var swapActionHandler: ()->Void

    
    var body: some View {
        VStack {
            
            LocationField(prompt: pickupSelection?.name ?? "Pickup Location") {
                locationSelection = .pickup
            }
            LocationField(prompt: dropSelection?.name ?? "Drop Location") {
                locationSelection = .drop
            }
            
        }
        .overlay(alignment: .trailing) {
            Button(action: swapActionHandler) {
                Image(systemName: "arrow.up.and.down.circle.fill")
                    .font(.largeTitle)
            }
            .applyBoxShadowEffect(shape: .circle, blurRadius: 3, y: 0)
            .padding(.trailing)
        }
    }
    
    private func defaultSwapper() {
        let pickup = pickupSelection
        pickupSelection = dropSelection
        dropSelection = pickup
    }
}

#Preview {
    struct Provide: View {
        @State var pick: Location? = previewModel.popularPlaces[0]
        @State var drop: Location? = previewModel.popularPlaces[1]
        
        @State var location: LocationSelectionTab? = nil
        
        
        var body: some View {
            TaxiLocationSelector(pickupSelection: $pick, dropSelection: $drop, locationSelection: $location) {}
        }
    }
    
    return Provide()
    
}
