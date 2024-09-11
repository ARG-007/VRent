//
//  TermsAndConditionPage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI

import MarkdownUI

struct TermsAndConditionPage: View {
    var body: some View {
        ScrollView {
            Markdown("""
            # VRent Terms and Conditions
            
            Welcome to VRent! Get ready to embark on a journey where our rules are as unconventional as our rides. Buckle up and dive into our Fight Club-inspired terms!
            
            ## Rules of the Road:
            
            ### 1. First Rule of VRent:
            **You do not talk about our terms and conditions.** (Okay, maybe just a little. But remember, this is like the first rule of Fight Club—keep it quiet and mysterious. Review them in hushed tones.)
            
            ### 2. Second Rule of VRent:
            **You can book multiple rides at a time.** (We know you might have multiple epic journeys ahead, and we’re all for it. Just remember, our drivers aren’t ready to brawl for your attention—they’re here to get you where you need to go.)
            
            ### 3. Third Rule of VRent:
            **Don’t mess with the driver’s playlist.** (Our cars are not your personal battlegrounds for music supremacy. Respect the groove, and save the epic DJ battles for your own home turf.)
            
            ## Disclaimer:
            **The first rule of VRent is:** Have an awesome time and reach your destinations safely. No secret fight clubs, no underground wars—just smooth rides and unforgettable experiences.
            
            Enjoy your VRent journey. Embrace the ride. Keep it cool. 
            
            ---
            
            Remember, the only fight you’re engaging in is with traffic, not each other. Ride on!
            """
            )
            .padding()
        }
    }
}

#Preview {
    TermsAndConditionPage()
}
