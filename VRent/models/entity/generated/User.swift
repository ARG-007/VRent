//
//  User.swift
//  VRent
//
//  Created by Arun R G on 02/09/24.
//

import Foundation
import SwiftUI

class User: Identifiable, Hashable, Codable {
    let id: Int
    var name: String
    var nickname: String
    var preferedTheme: String
    var phone: String
    var profilePic: String
    
    init(id: Int, name: String, nickname: String, preferedTheme: String, phone: String, profilePic: String) {
        self.id = id
        self.name = name
        self.nickname = nickname
        self.preferedTheme = preferedTheme
        self.phone = phone
        self.profilePic = profilePic
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


