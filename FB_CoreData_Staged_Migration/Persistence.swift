//
//  Created by Axel Le Pennec on 23/02/2024.
//  Copyright © 2024 Axel Le Pennec. All rights reserved.
// 

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        guard let modelURL: URL = Bundle.main.url(forResource: "Model", withExtension: "momd") else {
            fatalError("Unable to find Model data model in the bundle.")
        }
        
        guard let coreDataModel: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to create the Core Data model.")
        }
        
        container = NSPersistentContainer(
            name: "Database",
            managedObjectModel: coreDataModel
        )


        let v1ModelChecksum: String = "43TdyQILlgOK3x7s2VFAVs76F26kHUYhsJ2kgXcen8Y="
        
        let v1ModelReference: NSManagedObjectModelReference = NSManagedObjectModelReference(
            name: "Model",
            in: Bundle.main,
            versionChecksum: v1ModelChecksum
        )
        
//        let v1ModelReference: NSManagedObjectModelReference = NSManagedObjectModelReference(
//            model: coreDataModel,
//            versionChecksum: v1ModelChecksum
//        )
//        
//        let v1ModelReference: NSManagedObjectModelReference = NSManagedObjectModelReference(
//            fileURL: modelURL,
//            versionChecksum: v1ModelChecksum
//        )
        
        
        let v2ModelChecksum: String = "2IT0LVliuZ99UHyhh0CjbSPY6nzWtAy5tpseH8QWHuw="
        
        let v2ModelReference: NSManagedObjectModelReference = NSManagedObjectModelReference(
            name: "Model 2",
            in: Bundle.main,
            versionChecksum: v2ModelChecksum
        )
        
//        let v2ModelReference: NSManagedObjectModelReference = NSManagedObjectModelReference(
//            fileURL: modelURL,
//            versionChecksum: v2ModelChecksum
//        )
//        
//        let v2ModelReference: NSManagedObjectModelReference = NSManagedObjectModelReference(
//            model: coreDataModel,
//            versionChecksum: v2ModelChecksum
//        )
                    
        let customStage: NSCustomMigrationStage = NSCustomMigrationStage(
            migratingFrom: v1ModelReference,
            to: v2ModelReference
        )

        let migrationManager: NSStagedMigrationManager = NSStagedMigrationManager([customStage])
        
        let description = container.persistentStoreDescriptions.first
        description?.setOption(migrationManager, forKey: NSPersistentStoreStagedMigrationManagerOptionKey)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
