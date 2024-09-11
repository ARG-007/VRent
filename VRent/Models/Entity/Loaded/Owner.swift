//
//  Owner.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation

class Owner: Codable, Identifiable{
    let id: Int
    let joinedOn: Date
    let name: String
    
}

extension Owner: Hashable {
    static func == (lhs: Owner, rhs: Owner) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
