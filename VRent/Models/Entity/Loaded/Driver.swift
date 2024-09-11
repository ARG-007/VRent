//
//  Driver.swift
//  VRent
//
//  Created by Arun R G on 26/08/24.
//

import Foundation

class Driver: Codable, Identifiable {
    let id: Int
    let name: String
    let joinedOn: Date = Date()
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
}

extension Driver: Hashable {
    static func == (lhs: Driver, rhs: Driver) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
