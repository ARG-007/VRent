//
//  LegalNoticePage.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import SwiftUI
import MarkdownUI

struct LegalNoticePage: View {
    var body: some View {
        ScrollView {
            Markdown {
            """
            # VRent Legal Notice
            
            ## Legal Notice
            
            Welcome to VRent! This Legal Notice outlines the terms and conditions governing the use of our services. By using VRent, you agree to comply with the following legal provisions:
            
            ### 1. Acceptance of Terms
            By accessing or using VRent’s services, you agree to be bound by these terms and conditions. If you do not agree, you should refrain from using our services.
            
            ### 2. Use of Services
            You agree to use VRent in accordance with all applicable laws and regulations. Unauthorized use or abuse of our services may result in suspension or termination of your account.
            
            ### 3. Booking and Payments
            All bookings made through VRent are subject to availability and confirmation. Payments for services are processed securely. You are responsible for paying all applicable fees and charges associated with your use of VRent.
            
            ### 4. Liability
            VRent shall not be liable for any indirect, incidental, special, or consequential damages arising from the use of our services. Our total liability is limited to the maximum extent permitted by law.
            
            ### 5. Privacy
            We value your privacy. Our [Privacy Policy](#) details how we collect, use, and protect your personal information. By using VRent, you consent to our privacy practices.
            
            ### 6. Changes to Terms
            VRent reserves the right to modify these terms and conditions at any time. Any changes will be communicated to users through the app or via email. Continued use of the services after changes constitutes acceptance of the revised terms.
            
            ### 7. Governing Law
            These terms and conditions are governed by the laws of [Your Jurisdiction]. Any disputes arising from the use of VRent will be resolved in the courts of [Your Jurisdiction].
            
            ### 8. Contact Information
            For any questions or concerns regarding these terms, please contact us at [support@vrent.com](mailto:support@vrent.com) or through our customer support system.
            
            ---
            
            Thank you for choosing VRent. Your adherence to these terms ensures a smooth and enjoyable experience. May your journeys be as seamless as a well-argued case!
            
            ---
            
            """
            }
            .padding()
        }
    }
}

#Preview {
    LegalNoticePage()
}
