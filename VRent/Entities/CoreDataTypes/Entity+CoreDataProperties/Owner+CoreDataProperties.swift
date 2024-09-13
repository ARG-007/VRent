//
//  Owner+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData


extension Owner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: "Owner")
    }

    // MARK: - Attributes
    @NSManaged public var id: UUID
    @NSManaged public var joinedOn: Date
    @NSManaged public var name: String
    @NSManaged public var fleet: Set<Vehicle>

}

// MARK: Generated accessors for fleet
extension Owner {

    @objc(addFleetObject:)
    @NSManaged public func addToFleet(_ value: Vehicle)

    @objc(removeFleetObject:)
    @NSManaged public func removeFromFleet(_ value: Vehicle)

    @objc(addFleet:)
    @NSManaged public func addToFleet(_ values: Set<Vehicle>)

    @objc(removeFleet:)
    @NSManaged public func removeFromFleet(_ values: Set<Vehicle>)

}

extension Owner : Identifiable {

}
