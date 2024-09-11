//
//  BookingsTab.swift
//  VRent
//
//  Created by Arun R G on 03/09/24.
//

import SwiftUI

struct BookingsTab: View {
    @GuestMode var guestMode
    
    var body: some View {
        if(guestMode) {
            SignInRequestPage()
        } else {
            UserBookings()
        }
    }
}

#Preview {
    BookingsTab()
}
