//
//  RentingTab.swift
//  CarHub
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI


extension TimeInterval {
    var min: TimeInterval { self * 60 }
    var hr: TimeInterval { self * 3600}
    var day: TimeInterval { self * 3600 * 24 }
}

struct RentSearchQuery {
    var pickupLocation: String
    var pickupDate: Date
    private var dropDate: Date
    var dropoffDate: Date {
        get {
            dropDate
        }
        set {
            guard self.pickupDate < newValue else {
                return
            }
            self.dropDate = newValue
        }
    }
    
    var isSelfDrive: Bool
    var isRequiredDeliver: Bool
    
    var duration: TimeInterval{
//        Measurement(value: pickupDate.distance(to: dropDate), unit: .seconds)
        pickupDate.distance(to: dropDate)
    }
    
    var durationFormatted: String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = .full
        dateFormatter.allowedUnits = [.day, .hour, .minute]
        
        return dateFormatter.string(from: duration)!
    }
    
    init() {
        self.pickupLocation = ""
        self.pickupDate = Date()
        self.dropDate = self.pickupDate.advanced(by: 1.day)
        self.isSelfDrive = false
        self.isRequiredDeliver = false
    }
    
    
}

struct RentingTab: View {
    @State var searchQuery = RentSearchQuery()
    
    var durationFormatted: String {
        let duration = searchQuery.pickupDate.distance(to: searchQuery.dropoffDate)
        if #available(iOS 16.0, *) {
            return Duration
                .seconds(duration)
                .formatted(
                    .units(
                        allowed: [.days, .hours, .minutes]
                    )
                )
        } else {
            let dateFormatter = DateComponentsFormatter()
            dateFormatter.unitsStyle = .full
            dateFormatter.allowedUnits = [.day, .hour, .minute]
            
            return dateFormatter.string(from: duration)!
        }
    }
    
    var body: some View {
        Form {
            TextField("Pickup Location", text: $searchQuery.pickupLocation)
            DatePicker("Pickup Date",
                       selection: $searchQuery.pickupDate,
                       in: Date()...Date().advanced(by: 90.day),
                       displayedComponents: .date
            )
            DatePicker("Drop Date",
                       selection: $searchQuery.dropoffDate,
                       in: max(searchQuery.pickupDate,Date())...Date().advanced(by: 90.day),
                       displayedComponents: .date
            )
            Text("Duration: \(searchQuery.durationFormatted)")
        }
    }
}

#Preview {
    RentingTab()
}
