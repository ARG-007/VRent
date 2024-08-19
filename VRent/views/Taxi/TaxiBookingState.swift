//
//  TaxiBookingState.swift
//  VRent
//
//  Created by Arun R G on 19/08/24.
//

import Foundation

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


struct TaxiBookingState {
    
    private var taxiBookingAttributes: TaxiBookingAttributes
    
    var pickupLocation: SearchLocation? {
        get { taxiBookingAttributes.pickupLocation }
        set {
            if(newValue == dropOffLocation) {
                pickupLocationField = .invalid("Pickup Location Must Be Different From Drop Location")
            }else if newValue == nil {
                pickupLocationField = .unset
            } else {
                pickupLocationField = .valid
            }
            taxiBookingAttributes.pickupLocation = newValue
        }
    }
    
    var dropOffLocation: SearchLocation? {
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
        }
    }
    
    var pickupTime: Date {
        get { taxiBookingAttributes.pickupTime }
        set { taxiBookingAttributes.pickupTime = newValue }
    }
    
    var passengerCount: Int {
        get { taxiBookingAttributes.passengerCount }
        set { taxiBookingAttributes.passengerCount = newValue }
    }
    
    var vehicleType: VehicleType {
        get { taxiBookingAttributes.requestedVehicleType }
        set { taxiBookingAttributes.requestedVehicleType = newValue }
    }
    
    
    
    private(set) var pickupLocationField: FieldState = .unset
    private(set) var dropOffLocationField: FieldState = .unset
    
    
    
    var allFieldsValid: Bool {
        pickupLocationField == .valid
        && dropOffLocationField == .valid
    }
    
    init() {
        taxiBookingAttributes = TaxiBookingAttributes()
    }
    
    
}
