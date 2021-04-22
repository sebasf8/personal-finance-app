//
//  StatementItemRepository.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 21/04/2021.
//

import CoreData

protocol StatementItemRepository {
    func findall() throws -> [StatementItem]
    func findByParameters(params: StatementItemParameters) throws -> [StatementItem]
    func save(_ statementItem: StatementItem) throws
}

struct StatementItemCoreDataRepository: StatementItemRepository {
    let context: NSManagedObjectContext
    static let kEntityName = "StatementItem"
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func findall() throws -> [StatementItem] {
        try context.fetch(NSFetchRequest(entityName: StatementItemCoreDataRepository.kEntityName))
    }
    
    func findByParameters(params: StatementItemParameters) throws -> [StatementItem] {
        let fetchRequest = NSFetchRequest<StatementItem>(entityName: StatementItemCoreDataRepository.kEntityName)
        
        fetchRequest.predicate = NSPredicate(format: "typeValue == %@", params.type.rawValue)
        
        return try context.fetch(fetchRequest)
    }
    
    func save(_ statementItem:StatementItem) throws {
        try context.save()
    }
}
