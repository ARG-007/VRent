//
//  RentTimePicker.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct RentTimePicker: View {
    
    let prompt: String
    @Binding var selection: Date
    var range: ClosedRange<Date>
    
    init(_ prompt: String, selection: Binding<Date>, range: ClosedRange<Date>) {
        self.prompt = prompt
        self._selection = selection
        self.range = range
    }
    
    
    var body: some View {
        VStack(spacing: 10){
            Text(prompt)
                .font(.title3)
                .fontWeight(.semibold)
            Text(selection, format: .dateTime.day().month().year())
            DatePicker(
                prompt,
                selection: $selection,
                in: range,
                displayedComponents: .hourAndMinute
            )
            .setDatePickerInterval(30)
        }
    }
}

#Preview {
    RentTimePicker(
        "Test",
        selection: .constant(.now),
        range: Date.now...Date.distantFuture
    )
}
