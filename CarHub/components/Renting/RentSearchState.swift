//
//  RentSearchState.swift
//  CarHub
//
//  Created by Arun R G on 31/07/24.
//

import Foundation

struct RentSearchState {
    private var search: RentSearchQuery
    
    private let calendar = Calendar.current
    private let postponeRentStartBy = DateComponents(hour: 1)
    private let maximumRentDuration = DateComponents(month: 3)
    
    let minimumRentingHours = DateComponents(hour: 4, minute: 0, second: 0)
    
    var earliestRentDate: Date {
        let earlyValidDate = calendar.date(byAdding: postponeRentStartBy, to: .now)!
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: earlyValidDate)
        
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)!
    }
    
    var lastRentDate: Date {
        let lastValidDate = calendar.date(byAdding: maximumRentDuration, to: earliestRentDate)!
        return calendar.date(bySetting: .hour, value: 23, of: lastValidDate)!
    }
    
    var earliestDropDate: Date { calendar.date(byAdding: minimumRentingHours, to: search.pickupDate)! }
    var lastPickupDate: Date { calendar.date(byAdding: .hour, value: -minimumRentingHours.hour!,to: lastRentDate)! }
    
    var pickupDateValidRange: ClosedRange<Date> { earliestRentDate...lastPickupDate }
    var dropDateValidRange: ClosedRange<Date> { earliestDropDate...lastRentDate }
    
    var pickupDate: Date {
        get { search.pickupDate }
        set {
            search.pickupDate = newValue
            if(dropDate<earliestDropDate) {
                dropDate = earliestDropDate
            }
        }
    }
    
    var dropDate: Date {
        get { search.dropDate }
        set { search.dropDate = newValue }
    }
    
    var pickupLocation: String {
        get {search.pickupLocation}
        set {search.pickupLocation = newValue}
    }
    
    var isSelfDrive: Bool {
        get {search.isSelfDrive}
        set {search.isSelfDrive = newValue}
    }
    
    var isRequiredDelivery: Bool {
        get {search.isRequiredDeliver}
        set {search.isRequiredDeliver = newValue}
    }

    init() {
        let tempRentStartDate = calendar.date(byAdding: postponeRentStartBy, to: .now)!
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tempRentStartDate)
        components.minute = 0
        components.second = 0
        
        let earliestPickupDate = calendar.date(from: components)!
        let earliestDropDate = calendar.date(byAdding: minimumRentingHours, to: earliestPickupDate)!
        
        search = RentSearchQuery( pickupDate: earliestPickupDate, dropDate: earliestDropDate )
    }
    
    init(forSearch: RentSearchQuery) {
        search = forSearch
    }
    
    
    func getRentSearchQuery() -> RentSearchQuery {
        search
    }
    
    var duration: Measurement<UnitDuration> {
        Measurement(value: pickupDate.distance(to: dropDate), unit: .seconds)
    }
    
    var durationFormatted: String {
        return Duration
            .seconds(duration.value)
            .formatted(.units(allowed: [.days, .hours, .minutes]))
            .capitalized
    }
}
