//
//  BookingStatus.swift
//  VRent
//
//  Created by Arun R G on 29/08/24.
//

import Foundation

public enum BookingState: Int16, Hashable, Codable {
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
    
    func canTransition(to newStatus: BookingState) -> Bool {
        // Already in that State
        guard self != newStatus else {return false}
        
        return switch(newStatus) {
            case .Active:
                self == .Booked || self == .Rescheduled
            case .Booked: false
            case .Completed:
                self == .Active
            case .Cancelled, .Rescheduled:
                self == .Booked
        }
    }
}

public class BookingStatus: NSObject, NSSecureCoding {
    private(set) var current: BookingState
    private(set) var history: Dictionary<BookingState, Date>
    
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(current.rawValue, forKey: "CurrentState")
        let encodedHistory = history.map { ($0.rawValue, $1) }
        coder.encode(Dictionary(uniqueKeysWithValues: encodedHistory), forKey: "BookingHistory")
    }
    
    public required init?(coder: NSCoder) {
        let decodedState = BookingState(rawValue: (coder.decodeObject(forKey: "CurrentState") as? Int16 ?? 3)) ?? .Cancelled
        let decodedHistory = coder
            .decodeDictionary(withKeysOfClasses: [NSNumber.self], objectsOfClasses: [NSDate.self], forKey: "BookingHistory")!
            .map { (BookingState(rawValue: $0 as! Int16)!, $1 as! Date)}
        
        current = decodedState
        history = Dictionary(decodedHistory, uniquingKeysWith: { $1 })
    }
    
    public override init() {
        current = .Booked
        history = [.Booked : .now]
    }
    
    func canBe(_ transitionState: BookingState) -> Bool {
        current.canTransition(to: transitionState)
    }
    
    func dateWhen(_ state: BookingState) -> Date? {
        history[state]
    }
    
    func transition(to newState: BookingState) -> Bool {
        guard current.canTransition(to: newState) else { return false }
        
        current = newState
        return true
    }
}


@objc(BookingStatusSecureCodingTransformer)
class BookingStatusSecureCodingTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: BookingStatusSecureCodingTransformer.self))
    
    override static var allowedTopLevelClasses: [AnyClass] {
        [NSNumber.self ,BookingStatus.self]
    }
    
    static func register() {
        print("Register: \(name)")
        let transformer = BookingStatusSecureCodingTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
