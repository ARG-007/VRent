//
//  RentalBooking+CoreDataClass.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData

@objc(RentalBooking)
public class RentalBooking: NSManagedObject {

    convenience init?(context: NSManagedObjectContext,data rentalData: Rentable) {
        guard let pickup = rentalData.rentDetails.pickupLocation else {return nil}
        
        self.init(context: context)
        
        id = UUID()
        
        pickupLocation = pickup
        pickupTime = rentalData.rentDetails.pickupDate
        dropTime = rentalData.rentDetails.dropDate
        isSelfDriving = rentalData.rentDetails.isSelfDrive
        needToDeliver = rentalData.rentDetails.isRequiredDeliver
        
        nsBaseCost = rentalData.baseCost as NSDecimalNumber
        nsDeliveryCost = rentalData.deliveryCost as NSDecimalNumber
        nsDriverCost = rentalData.driverCost as NSDecimalNumber
        nsTotalCost = rentalData.totalCost as NSDecimalNumber
        selectedVehicle = rentalData.vehicle
        
        
        bookingStatus = BookingStatus()
    }
    
    var baseCost: Decimal { nsBaseCost as Decimal }
    var deliveryCost: Decimal { nsDeliveryCost as Decimal }
    var driverCost: Decimal { nsDriverCost as Decimal }
    var totalCost: Decimal { nsTotalCost as Decimal }
    
    var duration: Measurement<UnitDuration> {
        Measurement(value: pickupTime.distance(to: dropTime), unit: .seconds)
    }
}
