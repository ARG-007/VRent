//
//  Vehicle+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    // MARK: - Attributes
    @NSManaged public var id: UUID
    @NSManaged public var spec: VehicleSpecs
    @NSManaged public var ownedBy: Owner
    @NSManaged public var addedOn: Date
    @NSManaged public var boughtOnYear: Int16
    @NSManaged public var images: [URL]
    @NSManaged public var nsPricePerHR: NSDecimalNumber
    @NSManaged public var rating: Double
    @NSManaged public var tripsCompleted: Int64
    
    // MARK: - Tracking
    @NSManaged public var locationLatitude: Double
    @NSManaged public var locationLongitude: Double
    
    // MARK: - Involvements
    @NSManaged public var rentalBookings: Set<RentalBooking>
    @NSManaged public var taxiBookings: Set<TaxiBooking>
    @NSManaged public var favoritedBy: Set<User>

}

// MARK: Generated accessors for favoritedBy
extension Vehicle {

    @objc(addFavoritedByObject:)
    @NSManaged public func addToFavoritedBy(_ value: User)

    @objc(removeFavoritedByObject:)
    @NSManaged public func removeFromFavoritedBy(_ value: User)

    @objc(addFavoritedBy:)
    @NSManaged public func addToFavoritedBy(_ values: Set<User>)

    @objc(removeFavoritedBy:)
    @NSManaged public func removeFromFavoritedBy(_ values: Set<User>)

}

// MARK: Generated accessors for rentalBookings
extension Vehicle {

    @objc(addRentalBookingsObject:)
    @NSManaged public func addToRentalBookings(_ value: RentalBooking)

    @objc(removeRentalBookingsObject:)
    @NSManaged public func removeFromRentalBookings(_ value: RentalBooking)

    @objc(addRentalBookings:)
    @NSManaged public func addToRentalBookings(_ values: Set<RentalBooking>)

    @objc(removeRentalBookings:)
    @NSManaged public func removeFromRentalBookings(_ values: Set<RentalBooking>)

}

// MARK: Generated accessors for taxiBookings
extension Vehicle {

    @objc(addTaxiBookingsObject:)
    @NSManaged public func addToTaxiBookings(_ value: TaxiBooking)

    @objc(removeTaxiBookingsObject:)
    @NSManaged public func removeFromTaxiBookings(_ value: TaxiBooking)

    @objc(addTaxiBookings:)
    @NSManaged public func addToTaxiBookings(_ values: Set<TaxiBooking>)

    @objc(removeTaxiBookings:)
    @NSManaged public func removeFromTaxiBookings(_ values: Set<TaxiBooking>)

}

extension Vehicle : Identifiable {

}
