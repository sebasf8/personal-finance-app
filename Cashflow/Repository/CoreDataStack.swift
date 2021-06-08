//
//  File.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//

import Foundation
import CoreData

class CoreDataStack: DBHelperProtocol {
    typealias ObjectType = NSManagedObject
    typealias PredicateType = NSPredicate

    static let shared = CoreDataStack()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Cashflow")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            fatalError("Error saving the context while creating an object")
        }
    }

    func fetch<T: NSManagedObject>(_ objectType: T.Type,
                                   predicate: NSPredicate? = nil,
                                   limit: Int? = nil) -> Result<[T], Error> {

        let request = objectType.fetchRequest()
        request.predicate = predicate

        if let limit = limit {
            request.fetchLimit = limit
        }

        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }

    func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {

        let result = fetch(objectType, predicate: predicate, limit: 1)

        switch result {
        case .success(let todos):
            return .success(todos.first)
        case .failure(let error):
            return .failure(error)
        }
    }

    func update(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while updating an object")
        }
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }

    func saveContext () {
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
