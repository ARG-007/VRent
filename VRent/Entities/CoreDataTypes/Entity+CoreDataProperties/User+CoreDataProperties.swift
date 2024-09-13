//
//  User+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    // MARK: - User Attributes
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var avatar: String
    @NSManaged public var nickname: String
    @NSManaged public var phone: String
    
    // MARK: - Activities
    @NSManaged public var favorites: Array<Vehicle>
    @NSManaged public var taxiBookings: Array<TaxiBooking>
    @NSManaged public var rentalBookings: Array<RentalBooking>

}

// MARK: Generated accessors for favorites
extension User {

    @objc(insertObject:inFavoritesAtIndex:)
    @NSManaged public func insertIntoFavorites(_ value: Vehicle, at idx: Int)

    @objc(removeObjectFromFavoritesAtIndex:)
    @NSManaged public func removeFromFavorites(at idx: Int)

    @objc(insertFavorites:atIndexes:)
    @NSManaged public func insertIntoFavorites(_ values: [Vehicle], at indexes: NSIndexSet)

    @objc(removeFavoritesAtIndexes:)
    @NSManaged public func removeFromFavorites(at indexes: NSIndexSet)

    @objc(replaceObjectInFavoritesAtIndex:withObject:)
    @NSManaged public func replaceFavorites(at idx: Int, with value: Vehicle)

    @objc(replaceFavoritesAtIndexes:withFavorites:)
    @NSManaged public func replaceFavorites(at indexes: NSIndexSet, with values: [Vehicle])

    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: Vehicle)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: Vehicle)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: Array<Vehicle>)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: Array<Vehicle>)

}

// MARK: Generated accessors for taxiBookings
extension User {

    @objc(insertObject:inTaxiBookingsAtIndex:)
    @NSManaged public func insertIntoTaxiBookings(_ value: TaxiBooking, at idx: Int)

    @objc(removeObjectFromTaxiBookingsAtIndex:)
    @NSManaged public func removeFromTaxiBookings(at idx: Int)

    @objc(insertTaxiBookings:atIndexes:)
    @NSManaged public func insertIntoTaxiBookings(_ values: [TaxiBooking], at indexes: NSIndexSet)

    @objc(removeTaxiBookingsAtIndexes:)
    @NSManaged public func removeFromTaxiBookings(at indexes: NSIndexSet)

    @objc(replaceObjectInTaxiBookingsAtIndex:withObject:)
    @NSManaged public func replaceTaxiBookings(at idx: Int, with value: TaxiBooking)

    @objc(replaceTaxiBookingsAtIndexes:withTaxiBookings:)
    @NSManaged public func replaceTaxiBookings(at indexes: NSIndexSet, with values: [TaxiBooking])

    @objc(addTaxiBookingsObject:)
    @NSManaged public func addToTaxiBookings(_ value: TaxiBooking)

    @objc(removeTaxiBookingsObject:)
    @NSManaged public func removeFromTaxiBookings(_ value: TaxiBooking)

    @objc(addTaxiBookings:)
    @NSManaged public func addToTaxiBookings(_ values: Array<TaxiBooking>)

    @objc(removeTaxiBookings:)
    @NSManaged public func removeFromTaxiBookings(_ values: Array<TaxiBooking>)

}

// MARK: Generated accessors for rentalBookings
extension User {

    @objc(insertObject:inRentalBookingsAtIndex:)
    @NSManaged public func insertIntoRentalBookings(_ value: RentalBooking, at idx: Int)

    @objc(removeObjectFromRentalBookingsAtIndex:)
    @NSManaged public func removeFromRentalBookings(at idx: Int)

    @objc(insertRentalBookings:atIndexes:)
    @NSManaged public func insertIntoRentalBookings(_ values: [RentalBooking], at indexes: NSIndexSet)

    @objc(removeRentalBookingsAtIndexes:)
    @NSManaged public func removeFromRentalBookings(at indexes: NSIndexSet)

    @objc(replaceObjectInRentalBookingsAtIndex:withObject:)
    @NSManaged public func replaceRentalBookings(at idx: Int, with value: RentalBooking)

    @objc(replaceRentalBookingsAtIndexes:withRentalBookings:)
    @NSManaged public func replaceRentalBookings(at indexes: NSIndexSet, with values: [RentalBooking])

    @objc(addRentalBookingsObject:)
    @NSManaged public func addToRentalBookings(_ value: RentalBooking)

    @objc(removeRentalBookingsObject:)
    @NSManaged public func removeFromRentalBookings(_ value: RentalBooking)

    @objc(addRentalBookings:)
    @NSManaged public func addToRentalBookings(_ values: Array<RentalBooking>)

    @objc(removeRentalBookings:)
    @NSManaged public func removeFromRentalBookings(_ values: Array<RentalBooking>)

}

extension User : Identifiable {

}
