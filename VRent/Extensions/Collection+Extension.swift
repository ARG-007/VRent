//
//  Collection + Extension.swift
//  VRent
//
//  Created by Arun R G on 30/08/24.
//

import Foundation

extension Collection {
    
    /**
     [Custom Extension]
     Randomely Picks `n` or `count-1` items (whichever is the smallest) . The returned `[items]` sequence does not follow any order.
     */
    func randomPick(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(Swift.min(n, count-1)) }
}
