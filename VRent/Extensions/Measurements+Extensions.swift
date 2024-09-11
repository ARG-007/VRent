//
//  Measurements+Extensions.swift
//  VRent
//
//  Created by Arun R G on 21/08/24.
//

import Foundation

extension Measurement<UnitLength> {
    /** A 0 KM Measurement Value*/
    static var zeroKilometer: Self { Measurement<UnitLength>(value: 0, unit: .kilometers) }
}
