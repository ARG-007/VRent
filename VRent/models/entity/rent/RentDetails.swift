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
    var isRequiredDeliver: Bool = false
    
    var duration: Measurement<UnitDuration> {
        Measurement(value: pickupDate.distance(to: dropDate), unit: .seconds)
    }
}
