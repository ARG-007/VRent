//
//  Model.swift
//  VRent
//
//  Created by Arun R G on 12/09/24.
//

import Foundation
import Combine
import CoreData

class Model: ObservableObject {
    static let shared: Model = Model()
    
    /**
     Persistent Container
     */
    private(set) var container: NSPersistentContainer
    
    /**
     Check this to know whether the stores are loaded without error.
     If this is `true`, then persistent stores are loaded properly,
     If `false`, then some error occured during loading, which results in data not persisting.
     */
    private(set) var storesSuccessfullyLoaded: Bool = true
    
    private init() {
        LocationSecureCodingTransformer.register()
        BookingStatusSecureCodingTransformer.register()
        
        container = NSPersistentContainer(name: "VRent")
        
        firstLaunchInitialization()
        
        container.loadPersistentStores {[weak self] storeDescription, error in
            if let error {
                print("Error during Loading persistent store loading: \(error)")
                self?.storesSuccessfullyLoaded = false
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /**
     Copies Preloaded DB to the CoreData maintained Location at App's First Successful Initial Launch.
     If an Errors occurs during the operation, retries on next launch until the successfully copied.
     Should be called before loading persistent stores, unexpected results will occur if called after loading stores.
     */
    private func firstLaunchInitialization() {
        print("Attempting to Copy Prepopulated DB")
        let firstLaunchConfigured = UserDefaults.standard.bool(forKey: "applicationFirstLaunchConfigured")
        
        guard firstLaunchConfigured == false else {
            print("App already was launched and configured (hopefully).")
            return
        }
        
        guard let applicationSQLiteURL = container.persistentStoreDescriptions.first?.url else {
            print("First Launch Configuration Failed Due To Missing Store URL.")
            return
        }
        
        guard let bundlePreloadedDB = Bundle.main.url(forResource: "PreloadedDB", withExtension: "sqlite") else {
            print("Somehow the Preloaded DB in Resource Folder gone missing, How the heck did that happen?")
            return
        }
        
        let fileManager = FileManager.default
        
        do {
            
            if fileManager.fileExists(atPath: applicationSQLiteURL.path()) {
                print("An Imposter File is Already Exists at That Location, Deleting it")
                print("Delete Successful")
            }
            
            try fileManager.removeItem(at: applicationSQLiteURL)
            try fileManager.copyItem(at: bundlePreloadedDB, to: applicationSQLiteURL)
            UserDefaults.standard.set(true, forKey: "applicationFirstLaunchConfigured")
            print("Prepopulated DB was Copied Successfully")
        } catch {
            print("Copying Failed due to: \(error)")
        }
    }
    
    public func save() {
        print("Attempting to save uncommited changes to the persistent store")
        
        guard container.viewContext.hasChanges else {
            print("There are no uncommited changes")
            return
        }
        
        do {
            try container.viewContext.save()
            print("")
        } catch {
            print("Error occured during saving changes are not saved\nError: \(error)")
            
        }
    }
}
