//
//  TaxiBooking+CoreDataClass.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData

@objc(TaxiBooking)
public class TaxiBooking: NSManagedObject {

    convenience init?(context: NSManagedObjectContext,data taxiData: TaxiBookingAttributes) {
        guard let taxipickupLocation = taxiData.pickupLocation else { return nil }
        guard let dropOffLocation = taxiData.dropOffLocation else { return nil }
        
        self.init(context: context)
        
        
        id = UUID()
        
        pickupTime = taxiData.pickupTime
        pickupLocation = taxipickupLocation
        dropLocation = dropOffLocation
        passengerCount = taxiData.passengerCount
        requestedVehicleTypeRawValue = taxiData.requestedVehicleType.rawValue
        
        nsDriverCost = taxiData.driverCost as NSDecimalNumber
        nsVehicleCost = taxiData.vehicleCost as NSDecimalNumber
        nsTotalCost = taxiData.totalFare as NSDecimalNumber
        
        bookingstatus = BookingStatus()
    }
    
    var driverCost: Decimal { nsDriverCost as Decimal }
    var vehicleCost: Decimal { nsVehicleCost as Decimal }
    var totalCost: Decimal { nsTotalCost as Decimal }
}


