//
//  RentingScreenPages.swift
//  VRent
//
//  Created by Arun R G on 13/08/24.
//

import Foundation

enum RentingScreenPages: Hashable {
    case searchResults
    case vehicleDetails(Vehicle)
    case bookingDetails(Rentable)
    case success(Rentable)
}
