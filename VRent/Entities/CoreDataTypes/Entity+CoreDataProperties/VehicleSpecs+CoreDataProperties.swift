//
//  VehicleSpecs+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData


extension VehicleSpecs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VehicleSpecs> {
        return NSFetchRequest<VehicleSpecs>(entityName: "VehicleSpecs")
    }

    @NSManaged public var id: UUID
    
    // MARK: - Actualized Identifiers
    @NSManaged public var make: String
    @NSManaged public var model: String
    @NSManaged public var year: Int16
    
    // MARK: - Secondary Identifiers
    @NSManaged public var typeRawValue: String
    @NSManaged public var driveTrainRawValue: String
    @NSManaged public var fuelTypeRawValue: String
    @NSManaged public var transmissionRawValue: String
    
    // MARK: - Specifications
    @NSManaged public var capacity: Int32
    @NSManaged public var isLuxury: Bool
    @NSManaged public var fuelCapacity: Float
    
    // MARK: - Helper Set
    @NSManaged public var vehiclesOfSpec: Set<Vehicle>

}

// MARK: Generated accessors for vehiclesOfSpec
extension VehicleSpecs {

    @objc(addVehiclesOfSpecObject:)
    @NSManaged public func addToVehiclesOfSpec(_ value: Vehicle)

    @objc(removeVehiclesOfSpecObject:)
    @NSManaged public func removeFromVehiclesOfSpec(_ value: Vehicle)

    @objc(addVehiclesOfSpec:)
    @NSManaged public func addToVehiclesOfSpec(_ values: Set<Vehicle>)

    @objc(removeVehiclesOfSpec:)
    @NSManaged public func removeFromVehiclesOfSpec(_ values: Set<Vehicle>)

}

extension VehicleSpecs : Identifiable {

}
