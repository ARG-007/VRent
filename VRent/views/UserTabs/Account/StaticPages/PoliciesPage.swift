//
//  PoliciesPage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI
import MarkdownUI

struct PoliciesPage: View {
    var body: some View {
        ScrollView {
            Markdown {
            """
            # VRent Policies
            
            Welcome to VRent! Embark on your journey with us, where our policies are crafted to ensure a smooth and epic adventure. Read on to make your ride as legendary as a quest in The Witcher universe.
            
            ## General Policies
            
            ### 1. User Responsibility
            Just as Geralt always reads his contracts carefully, users must ensure that all information provided is accurate and up-to-date. This includes personal details, payment information, and ride preferences.
            
            ### 2. Vehicle Use
            All vehicles must be used in accordance with local traffic laws and regulations—no need to summon a Witcher’s signs to handle traffic. Users are responsible for any fines or penalties incurred during the rental period.
            
            ### 3. Booking and Cancellation
            - **Booking:** Like accepting a quest from a tavern bard, users may book multiple rides at a time through the app, subject to availability.
            - **Cancellation:** If you need to cancel a ride, you can do so through the app. Cancellation policies, including any applicable fees, are outlined in the booking confirmation and may vary based on timing and circumstances.
            
            ### 4. Payment
            Payments are processed securely through the app, as if safeguarded by a mage’s protective spells. Users agree to pay all charges associated with their bookings, including any additional fees for extended use or damages.
            
            ### 5. Damages and Loss
            Should any damage or loss occur during your journey, users are responsible for reporting it immediately to VRent. Consider this your responsibility as if handling the aftermath of a monster hunt.
            
            ### 6. Privacy
            Just as Geralt keeps his secrets close, VRent is committed to protecting your privacy. All personal information collected is used in accordance with our [Privacy Policy](#) and is kept confidential.
            
            ### 7. Support
            For any issues or support requests, our customer service team is here to assist you—like a trusted ally in your quests. Contact us through the app or via our support email at [support@vrent.com](mailto:support@vrent.com).
            
            ### 8. Modifications
            VRent reserves the right to modify these policies at any time. Like the ever-changing world of The Witcher, users will be notified of any significant changes through the app or via email.
            
            Thank you for choosing VRent. May your travels be as smooth as a well-crafted potion and as enjoyable as a night at the tavern!
            
            ---
            
            For more details, please refer to our [Terms and Conditions](#) and [Privacy Policy](#).
            
            """
            }
            .padding()
        }
    }
}

#Preview {
    PoliciesPage()
}
