//
//  RentQuery.swift
//  VRent
//
//  Created by Arun R G on 29/07/24.
//

import Foundation


struct RentSearchQuery: Codable {
    var pickupLocation: SearchLocation?
    var pickupDate: Date
    var dropDate: Date
    var isSelfDrive: Bool = false
    var isRequiredDeliver: Bool = false
}
