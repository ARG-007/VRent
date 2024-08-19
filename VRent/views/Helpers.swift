//
//  Helpers.swift
//  VRent
//
//  Created by Arun R G on 19/08/24.
//

import Foundation

/**
 Returns localized currency form of given Decimal value.
 Fallbacks to "INR" if no local currency is detected
 */
func localizedCurrency(_ currency: Decimal) -> String {
    return currency.formatted(.currency(code: Locale.autoupdatingCurrent.currency?.identifier ?? "INR"))
}




