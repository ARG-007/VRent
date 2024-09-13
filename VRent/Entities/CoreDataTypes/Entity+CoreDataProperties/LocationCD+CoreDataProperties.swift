//
//  LocationCD+CoreDataProperties.swift
//  TestCoreData
//
//  Created by Arun R G on 11/09/24.
//
//

import Foundation
import CoreData


extension LocationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationCD> {
        return NSFetchRequest<LocationCD>(entityName: "LocationCD")
    }

    @NSManaged public var location: Location

}

extension LocationCD : Identifiable {

}
