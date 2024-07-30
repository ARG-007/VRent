//
//  RentingTab.swift
//  CarHub
//
//  Created by Arun R G on 24/07/24.
//

import SwiftUI


extension View {
    func setDatePickerInterval(_ interval: Int) -> some View {
        self
            .onAppear() { UIDatePicker.appearance().minuteInterval = 30 }
            .onDisappear() { UIDatePicker.appearance().minuteInterval = 1 }
    }
}


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
        if #available(iOS 16.0, *) {
            return Duration
                .seconds(duration.value)
                .formatted(.units(allowed: [.days, .hours, .minutes]))
                .capitalized
        } else {
            let dateFormatter = DateComponentsFormatter()
            dateFormatter.unitsStyle = .full
            dateFormatter.allowedUnits = [.day, .hour, .minute]
            
            return dateFormatter.string(from: duration.value)!.capitalized
        }
    }
    
}


struct RentingTab: View {
    @State var searchState = RentSearchState()
    
    var pickupTimePicker: some View {
        VStack(spacing: 10){
            Text("Pickup Time")
                .font(.title3)
                .fontWeight(.semibold)
            Text(searchState.pickupDate, format: .dateTime.day().month().year())
            DatePicker(
                "Pickup Time",
                selection: $searchState.pickupDate,
                in: searchState.pickupDateValidRange,
                displayedComponents: .hourAndMinute
            )
            .setDatePickerInterval(30)
        }
    }
    
    var dropTimePicker: some View {
        VStack(spacing: 10){
            Text("Drop Time")
                .font(.title3)
                .fontWeight(.semibold)
            Text(searchState.dropDate, format: .dateTime.day().month().year())
            DatePicker(
                "Drop Time",
                selection: $searchState.dropDate,
                in: searchState.dropDateValidRange,
                displayedComponents: .hourAndMinute
            )
            .setDatePickerInterval(30)
        }
    }
    
    var duration: some View {
        HStack( spacing: 10) {
            Image(systemName: "hourglass")
                .imageScale(.large)
            Text(searchState.durationFormatted)
        }
    }
    
    var body: some View {
        Form {
            TextField("Pickup Location", text: $searchState.pickupLocation)
            
            DatePicker(
                "Pickup Date",
                selection: $searchState.pickupDate,
                in: searchState.pickupDateValidRange,
                displayedComponents: .date
            )
            
            DatePicker(
                "Drop Date",
                selection: $searchState.dropDate,
                in: searchState.dropDateValidRange,
                displayedComponents: .date
            )
            
            
            Section {
                VStack {
                    HStack(spacing: 20) {
                        pickupTimePicker
                            .frame(maxWidth: .infinity)
                        
                        dropTimePicker
                            .frame(maxWidth: .infinity)
                        
                    }
                    .labelsHidden()
                    
                    Divider()
                    
                    duration
                        .frame(maxWidth: .infinity)
                }
            }
            
            Section {
                HStack(spacing: 20) {
                    Toggle("Self Driving", isOn: $searchState.isSelfDrive)
                    Toggle("Delivery", isOn: $searchState.isRequiredDelivery)
                }
                
            }
            
            Button("Search", action: {print(searchState)})
                .frame(maxWidth: .infinity)
        }
        .tint(.orange)
    }
}

#Preview {
    RentingTab()
}
