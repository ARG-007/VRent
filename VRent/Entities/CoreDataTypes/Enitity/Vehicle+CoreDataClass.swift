//
//  Vehicle+CoreDataClass.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData
import CoreLocation

@objc(Vehicle)
public class Vehicle: NSManagedObject {
    var ratings: Rating {
        Rating(average: rating, tripsCompleted: Int(tripsCompleted))
    }
    
    var location: CLLocation {
        CLLocation(latitude: locationLatitude, longitude: locationLongitude)
    }
    
    var name: String { spec.fullQualifiedName }
    
    var pricePerHR: Decimal { nsPricePerHR as Decimal }
}
