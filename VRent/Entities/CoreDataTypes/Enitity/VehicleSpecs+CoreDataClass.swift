//
//  VehicleSpecs+CoreDataClass.swift
//  TestCoreData
//
//  Created by Arun R G on 09/09/24.
//
//

import Foundation
import CoreData

@objc(VehicleSpecs)
public class VehicleSpecs: NSManagedObject {
    var type: VehicleType {
        VehicleType(rawValue: self.typeRawValue)!
    }
    
    var driveTrain: DriveTrain {
        DriveTrain(rawValue: self.driveTrainRawValue)!
    }
    
    var fuelType: Fuel {
        Fuel(rawValue: self.fuelTypeRawValue)!
    }
    
    var transmission: Transmission {
        Transmission(rawValue: self.transmissionRawValue)!
    }
    
    var formattedYear: String {
        year.formatted(.number.grouping(.never))
    }
    
    var fullQualifiedName: String {
        "\(make) \(model) \(formattedYear)"
    }
}
