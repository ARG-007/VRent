//
//  RentSearchViewModel.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import Foundation

class RentSearchViewModel: ObservableObject {
    @Published private var search: RentDetails
    
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
        return calendar.date(bySetting: .hour, value: 0, of: lastValidDate)!
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
    
    var pickupLocation: Location? {
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
        
        search = RentDetails( pickupDate: earliestPickupDate, dropDate: earliestDropDate )
    }
    
    init(forSearch: RentDetails) {
        search = forSearch
    }
    
    
    func getRentSearchQuery() -> RentDetails {
        search
    }
    
    var duration: Measurement<UnitDuration> {
        search.duration
    }
    
    var durationFormatted: String {
        return Duration
            .seconds(search.duration.value)
            .formatted(.units(allowed: [.days, .hours, .minutes]))
            .capitalized
    }
    
    
}
