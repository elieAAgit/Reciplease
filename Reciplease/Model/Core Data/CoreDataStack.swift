//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Elie Arquier on 14/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    let name: String
    
    init(name: String) {
        self.name = name
    }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {

        let container = NSPersistentCloudKitContainer(name: name)
        let storeDescription = container.persistentStoreDescriptions.first
        storeDescription?.type = NSSQLiteStoreType
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    // MARK: - Core Data Save Context
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
