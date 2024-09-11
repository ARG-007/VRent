//
//  Cost.swift
//  VRent
//
//  Created by Arun R G on 16/08/24.
//

import Foundation



struct Cost {
    var amount: Decimal
    let currency: String
}

extension Cost: CustomStringConvertible {
    var description: String {
        amount.formatted(.currency(code: currency))
    }
}
