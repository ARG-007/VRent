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
            
//            TextField("Passenger Count", value: $passenger, format: .number)
            Text(passenger.formatted())
            //                            .padding(.leading)
                .contentTransition(.identity)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 50)
                .keyboardType(.numberPad)
                
            
            Stepper("Passenger Count",value: $passenger, in: 1...23)
                .labelsHidden()
        }
        
    }
}

#Preview {
    PassengerStepper(passenger: .constant(10))
}
