//
//  PriceRow.swift
//  VRent
//
//  Created by Arun R G on 09/08/24.
//

import SwiftUI

struct PriceRow: View {
    
    let value: Decimal
    let info: String
    
    init(_ prompt: String, _ value: Decimal) {
        self.value = value
        self.info = prompt
    }
    
    init(_ prompt: String, _ value: Double) {
        self.value = Decimal(value)
        self.info = prompt
    }
    
    var body: some View {
        HStack {
            Text(info)

                .fontWeight(.semibold)
            Spacer()
            Text(localizedCurrency(value))
        }
    }
}
#Preview {
    PriceRow("HDJDjkAHSD", 1321.213213)
}
