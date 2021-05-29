//
//  CashflowRepository.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation

import CoreData

protocol CashflowRepository {
    func fetch() throws -> Cashflow
    func fetchFor(year: Int) throws -> Cashflow
    func fetchFor(month: Int) throws -> Cashflow
    func save(_ statementItem: CashflowItem) throws
}

struct CashflowCoreDataRepository: CashflowRepository {
    let context: NSManagedObjectContext
    let kEntityName = "CashflowItem"

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetch() throws -> Cashflow {
        let fetchRequest = NSFetchRequest<CashflowItem>(entityName: kEntityName)
        let movements: [CashflowItem] = try context.fetch(fetchRequest)

        return Cashflow(movements: movements)
    }

    func fetchFor(year: Int) throws -> Cashflow {
        let fetchRequest = NSFetchRequest<CashflowItem>(entityName: kEntityName)

        let startOfYear = Calendar.current.startOfYear(Date()) as NSDate
        let endOfYear = Calendar.current.endOfYear(Date()) as NSDate

        fetchRequest.predicate = NSPredicate(format: "date >= %@ and date <= %@", startOfYear, endOfYear)

        let movements: [CashflowItem] = try context.fetch(fetchRequest)

        return Cashflow(movements: movements)
    }

    func fetchFor(month: Int) throws -> Cashflow {
        let fetchRequest = NSFetchRequest<CashflowItem>(entityName: kEntityName)

        let startOfMonth = Calendar.current.startOfMonth(Date()) as NSDate
        let endOfMonth = Calendar.current.endOfMonth(Date()) as NSDate

        fetchRequest.predicate = NSPredicate(format: "date >= %@ and date <= %@", startOfMonth, endOfMonth)

        let movements: [CashflowItem] = try context.fetch(fetchRequest)

        return Cashflow(movements: movements)
    }

    func save(_ movement: CashflowItem) throws {
        try context.save()
    }
}
