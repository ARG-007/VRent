//
//  User.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI

class User: Identifiable {
    let id: Int
    var name: String
    var preferedTheme: String
    var phone: String
    var profilePic: URL
    
    
    init(id: Int, name: String, preferedTheme: String, phone: String, profilePic: URL) {
        self.id = id
        self.name = name
        self.preferedTheme = preferedTheme
        self.phone = phone
        self.profilePic = profilePic
    }
}


