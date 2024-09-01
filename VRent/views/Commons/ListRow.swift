//
//  ListRow.swift
//  VRent
//
//  Created by Arun R G on 01/09/24.
//

import SwiftUI

struct ListRow: View {
    let info: String
    let value: String
    
    init( _ info: String, _ value: String) {
        self.info = info
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(info)
            Spacer()
            Text(value)
                .bold()
        }
    }
}

#Preview {
    ListRow("Test", "KJDHAKJH")
}
