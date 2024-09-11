//
//  TaxiBookingViewModel.swift
//  VRent
//
//  Created by Arun R G on 19/08/24.
//

import Foundation
import SwiftUI

@propertyWrapper struct InputField<Value> {
    
    enum FieldState {
        case valid
        case unset
        case invalid(String)
    }
    
    var wrappedValue: Value
    var state: FieldState = .valid
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}


class TaxiBookingViewModel: ObservableObject {
    
    @Published private var taxiBookingAttributes: TaxiBookingAttributes
    @Published var navigateToDetails: Bool = false
    
    @Published var locationSelectionSheet: LocationSelectionTab? = nil
    
    var estimatedPrice: Decimal { taxiBookingAttributes.totalFare }
    
    private(set) var pickupLocationField: FieldState = .unset
    private(set) var dropOffLocationField: FieldState = .unset
    @Published private(set) var sameLocationError = false
    
    var pickupLocation: Location? {
        get { taxiBookingAttributes.pickupLocation }
        set {
            if(newValue == dropOffLocation) {
                pickupLocationField = .invalid("Pickup Location Must Be Different From Drop Location")
            } else if newValue == nil {
                pickupLocationField = .unset
            } else {
                pickupLocationField = .valid
            }
            taxiBookingAttributes.pickupLocation = newValue
            resolveSheet()
        }
    }
    
    var dropOffLocation: Location? {
        get { taxiBookingAttributes.dropOffLocation }
        set {
            if(newValue == pickupLocation) {
                dropOffLocationField = .invalid("Drop Location Must Be Different From Pickup Location")
                
            } else if newValue == nil {
                pickupLocationField = .unset
            } else {
                dropOffLocationField = .valid
            }
            taxiBookingAttributes.dropOffLocation = newValue
            resolveSheet()
        }
    }
    
    var pickupTime: Date {
        get { taxiBookingAttributes.pickupTime }
        set { taxiBookingAttributes.pickupTime = newValue }
    }
    
    var passengerCount: Int {
        get { taxiBookingAttributes.passengerCount }
        set {
            
            guard newValue>0 && newValue<24 else {
                return
            }
            
            taxiBookingAttributes.requestedVehicleType = VehicleType.typeWithCapacity(newValue)
            taxiBookingAttributes.passengerCount = newValue
        }
    }
    
    var vehicleType: VehicleType {
        get { taxiBookingAttributes.requestedVehicleType }
        set {
            taxiBookingAttributes.passengerCount = newValue.capacity
            taxiBookingAttributes.requestedVehicleType = newValue
        }
    }
    
    
    
    var locationSame: Bool {
        (dropOffLocation != nil ) && (dropOffLocation == pickupLocation)
    }
    
    var allFieldsValid: Bool {
        pickupLocationField == .valid
        && dropOffLocationField == .valid
    }
    
    func getAttributes() -> TaxiBookingAttributes {
        taxiBookingAttributes
    }
    
    func continueToBook() {
        if allFieldsValid {
            navigateToDetails = true
        } else {
            resolveSheet()
        }
    }
    
    private func resolveSheet() {
        if( pickupLocation == nil ) {
            locationSelectionSheet = .pickup
        } else if (dropOffLocation == nil ) {
            locationSelectionSheet = .drop
        } else {
            locationSelectionSheet = nil
        }
    }
    
    func swapLocation() {
        let dropOff = taxiBookingAttributes.dropOffLocation
        taxiBookingAttributes.dropOffLocation = taxiBookingAttributes.pickupLocation
        taxiBookingAttributes.pickupLocation = dropOff
        
        
//        if let pickup = taxiBookingAttributes.pickupLocation,
//           let dropOff = taxiBookingAttributes.dropOffLocation {
//           }
    }
    
    init() {
        taxiBookingAttributes = TaxiBookingAttributes()
    }
    
    
}
