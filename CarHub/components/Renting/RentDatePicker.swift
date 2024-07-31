//
//  RentDatePicker.swift
//  CarHub
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct RentDatePicker: View {
    let prompt: String
    @Binding var selection: Date
    var range: ClosedRange<Date>
    
    init(_ prompt: String, selection: Binding<Date>, range: ClosedRange<Date>) {
        self.prompt = prompt
        self._selection = selection
        self.range = range
    }
    
    var body: some View {
        DatePicker(
            prompt,
            selection: $selection,
            in: range,
            displayedComponents: .date
        )
    }
}

#Preview {
    RentDatePicker(
        "Test",
        selection: .constant(.now),
        range: Date.now...Date.distantFuture
    )
}
