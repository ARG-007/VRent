//
//  RentQuery.swift
//  VRent
//
//  Created by Arun R G on 29/07/24.
//

import Foundation


struct RentDetails: Codable {
    var pickupLocation: Location?
    var pickupDate: Date
    var dropDate: Date
    var isSelfDrive: Bool = false
    var isRequiredDeliver: Bool = true
    
    var duration: Measurement<UnitDuration> {
        Measurement(value: pickupDate.distance(to: dropDate), unit: .seconds)
    }
}

extension RentDetails: Hashable {
    static func == (lhs: RentDetails, rhs: RentDetails) -> Bool{
        (lhs.pickupLocation?.name == rhs.pickupLocation?.name)
        && (lhs.pickupDate == rhs.pickupDate)
        && (lhs.dropDate == rhs.dropDate)
        && (lhs.isSelfDrive == rhs.isSelfDrive)
        && (lhs.isRequiredDeliver == rhs.isRequiredDeliver)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pickupLocation?.name)
        hasher.combine(pickupDate)
        hasher.combine(dropDate)
        hasher.combine(isSelfDrive)
        hasher.combine(isRequiredDeliver)
    }
}
