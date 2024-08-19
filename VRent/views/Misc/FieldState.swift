//
//  FieldState.swift
//  VRent
//
//  Created by Arun R G on 19/08/24.
//

import Foundation

enum FieldState: Equatable {
    case valid
    case invalid(String)
    case unset
}
