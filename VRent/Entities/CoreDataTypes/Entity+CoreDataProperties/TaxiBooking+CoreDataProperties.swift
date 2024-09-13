//
//  TaxiBooking+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData


extension TaxiBooking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaxiBooking> {
        return NSFetchRequest<TaxiBooking>(entityName: "TaxiBooking")
    }

    // MARK: - Attributes
    @NSManaged public var id: UUID
    @NSManaged public var pickupLocation: Location
    @NSManaged public var dropLocation: Location
    @NSManaged public var passengerCount: Int32
    @NSManaged public var pickupTime: Date
    @NSManaged public var requestedVehicleTypeRawValue: String
    @NSManaged public var bookedBy: User
    
    // MARK: - Tracking
    @NSManaged public var assignedVehicle: Vehicle
    @NSManaged public var bookingstatus: BookingStatus
    
    // MARK: - Estimates
    @NSManaged public var nsVehicleCost: NSDecimalNumber
    @NSManaged public var nsDriverCost: NSDecimalNumber
    @NSManaged public var nsTotalCost: NSDecimalNumber
    

}

extension TaxiBooking : Identifiable {

}
