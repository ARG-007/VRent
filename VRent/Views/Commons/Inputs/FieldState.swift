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
    
    var isValid: Bool {
        self == .valid
    }
    
    var errorString: String {
        switch(self) {
            case .invalid(let error) : error
            default : "            "
        }
    }
}
