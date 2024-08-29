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
        }
    }
    
    var pickupTime: Date {
        get { taxiBookingAttributes.pickupTime }
        set { taxiBookingAttributes.pickupTime = newValue }
    }
    
    var passengerCount: Int {
        get { taxiBookingAttributes.passengerCount }
        set {
            
            guard newValue>0 else {
                return
            }
            
            if(vehicleType.capacity < newValue) {
                taxiBookingAttributes.requestedVehicleType = VehicleType.typeWithCapacity(newValue)
            }
            taxiBookingAttributes.passengerCount = newValue
        }
    }
    
    var vehicleType: VehicleType {
        get { taxiBookingAttributes.requestedVehicleType }
        set {
            if(newValue.capacity < passengerCount) {
                taxiBookingAttributes.passengerCount = newValue.capacity
            }
            taxiBookingAttributes.requestedVehicleType = newValue
        }
    }
    
    var estimatedPrice: Decimal { taxiBookingAttributes.totalFare }
    
    private(set) var pickupLocationField: FieldState = .unset
    private(set) var dropOffLocationField: FieldState = .unset
    
    
    
    var allFieldsValid: Bool {
        pickupLocationField == .valid
        && dropOffLocationField == .valid
    }
    
    func getAttributes() -> TaxiBookingAttributes {
        taxiBookingAttributes
    }
    
    init() {
        taxiBookingAttributes = TaxiBookingAttributes()
    }
    
    
}
