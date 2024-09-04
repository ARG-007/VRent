//
//  BookingStatus.swift
//  VRent
//
//  Created by Arun R G on 29/08/24.
//

import Foundation

enum BookingStatus: Int, Hashable, Codable {
    case Booked
    case Active
    case Completed
    case Cancelled
    case Rescheduled
    
    var statusName: String {
        switch(self) {
        case .Booked: "Booked"
        case .Active: "Active"
        case .Cancelled: "Cancelled"
        case .Completed: "Completed"
        case .Rescheduled: "Rescheduled"
        }
    }
}

typealias BookingHistory = Dictionary<BookingStatus, Date>

extension BookingHistory {
    /**
     Transitions to the new state while recording time of transition with it.
     Returns `true` if the transition is successfully completed.
     else `false` if the transition is not an valid.
     */
    @discardableResult
    mutating func transition(to newState: Key) -> Bool {
        if(canTransition(to: newState)) {
            self.updateValue(.now, forKey: newState)
            return true
        } else {
            return false
        }
    }
    
    func canTransition(to nextState: Key ) -> Bool {
        if(self[nextState] == nil) {
            return switch(nextState) {
                case .Active:
                    self[.Cancelled] == nil && self[.Completed] == nil
                case .Booked:
                    isEmpty
                case .Completed:
                    self[.Active] != nil
                case .Cancelled:
                    self[.Active] == nil && self[.Rescheduled] == nil
                case .Rescheduled:
                    self[.Cancelled] == nil && self[.Active] == nil
            }
        }
        
        return false
    }
}
