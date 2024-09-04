//
//  PassengerStepper.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

struct PassengerStepper: View {
    @Binding var passenger: Int
    
    private var sliderBinding: Binding<Double> {
        
        Binding<Double> (
            get: { Double(passenger) },
            set: { passenger = Int($0)}
        )
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.fill")
                .padding(.bottom)
            
            Text(passenger.formatted())
                .font(.title3)
                .bold()
                .padding(.bottom)
            
            Stepper("Passenger Count",value: $passenger, in: 1...23)
                .labelsHidden()
        }
        .padding()
        
    }
}

#Preview {
    PassengerStepper(passenger: .constant(10))
}
