//
//  CashflowItemCoreDataRepository.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//

import Foundation
import CoreData

protocol CashflowItemRepository {
    func fetch() -> [CashflowItem]
    func fetchFor(year: Int) -> [CashflowItem]
    func fetchFor(month: Int) -> [CashflowItem]
    func save(_ cashflowItem: CashflowItem)
    func make() -> CashflowItem
}

class CashflowItemCoreDataRepository {
    static let shared: CashflowItemRepository = CashflowItemCoreDataRepository()

    var dbHelper: CoreDataStack = CoreDataStack.shared

    private init() { }

    private func fetchCategory(for cashflowItem: CashflowItem) -> CashflowItemMO? {
        guard let uuid = cashflowItem.uuid else { return nil }

        let predicate = NSPredicate(
            format: "uuid = %@",
            uuid as CVarArg)

        let result = dbHelper.fetchFirst(CashflowItemMO.self, predicate: predicate)
        switch result {
        case .success(let cashflowItemMO):
            return cashflowItemMO
        case .failure(_):
            return nil
        }
    }
}

extension CashflowItemCoreDataRepository: CashflowItemRepository {
    func fetch() -> [CashflowItem] {
        let result = dbHelper.fetch(CashflowItemMO.self)

        switch result {
        case .success(let cashflowItems):
            return cashflowItems
        case .failure(_):
            return []
        }
    }

    func fetchFor(year: Int) -> [CashflowItem] {
        let startOfYear = Calendar.current.startOfYear(Date())
        let endOfYear = Calendar.current.endOfYear(Date())

        return fetchAnInterval(from: startOfYear, to: endOfYear)
    }

    func fetchFor(month: Int) -> [CashflowItem] {
        let startOfMonth = Calendar.current.startOfMonth(Date())
        let endOfMonth = Calendar.current.endOfMonth(Date())

        return fetchAnInterval(from: startOfMonth, to: endOfMonth)
    }

    private func fetchAnInterval(from since: Date, to until: Date) -> [CashflowItem] {
        let predicate = NSPredicate(format: "date >= %@ and date <= %@", since as NSDate, until as NSDate)

        let result = dbHelper.fetch(CashflowItemMO.self, predicate: predicate)

        switch result {
        case .success(let cashflowItems):
            return cashflowItems
        case .failure(_):
            return []
        }
    }

    func save(_ cashflowItem: CashflowItem) {
        if cashflowItem.uuid != nil {
            update(for: cashflowItem)
        } else {
            add(cashflowItem)
        }
    }

    func make() -> CashflowItem {
        let category = CategoryCoreDataRepository.shared.make()
        let cashflowItem = CashflowItemMO(context: dbHelper.context)
        cashflowItem.category = category

        return cashflowItem
    }

    private func add(_ cashflowItem: CashflowItem) {
        guard let cashflowItemMO = cashflowItem as? CashflowItemMO else {
            fatalError("Implementation of cashflowItem is not a Managed Object")
        }
        cashflowItemMO.uuid = UUID()
        dbHelper.create(cashflowItemMO)
    }

    private func update(for cashflowItem: CashflowItem) {
        guard let cashflowItemMO = cashflowItem as? CashflowItemMO else {
            fatalError("Implementation of cashflowItem is not a Managed Object")
        }
        dbHelper.update(cashflowItemMO)
    }
}
