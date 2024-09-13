//
//  RentalBooking+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData


extension RentalBooking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RentalBooking> {
        return NSFetchRequest<RentalBooking>(entityName: "RentalBooking")
    }

    // MARK: - Attributes
    @NSManaged public var id: UUID
    @NSManaged public var pickupTime: Date
    @NSManaged public var dropTime: Date
    @NSManaged public var isSelfDriving: Bool
    @NSManaged public var needToDeliver: Bool
    @NSManaged public var pickupLocation: Location
    @NSManaged public var bookedBy: User
    @NSManaged public var selectedVehicle: Vehicle
    
    // MARK: - Tracking
    @NSManaged public var bookingStatus: BookingStatus
    // MARK: - Cost Estimates
    @NSManaged public var nsBaseCost: NSDecimalNumber
    @NSManaged public var nsDeliveryCost: NSDecimalNumber
    @NSManaged public var nsDriverCost: NSDecimalNumber
    @NSManaged public var nsTotalCost: NSDecimalNumber
    

}

extension RentalBooking : Identifiable {

}
