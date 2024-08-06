//
//  Owner.swift
//  VRent
//
//  Created by Arun R G on 05/08/24.
//

import Foundation

class Owner: Codable, Identifiable {
    let id: Int
    let joinedOn: Date
    let name: String
}
