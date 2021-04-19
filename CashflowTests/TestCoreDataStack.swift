//
//  CoreDataStack.swift
//  CashflowTests
//
//  Created by Sebastian Fernandez on 17/04/2021.
//

import CoreData
import Cashflow

class TestCoreDataStack {
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "Cashflow", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    public lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cashflow", managedObjectModel: TestCoreDataStack.model)
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

}

