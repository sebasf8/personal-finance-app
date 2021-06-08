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
            return cashflowItems.map { entity in
                entity.convertToCashflowItem()
            }
        case .failure(_):
            return []
        }
    }

    func fetchFor(year: Int) -> [CashflowItem] {
        let startOfYear = Calendar.current.startOfYear(Date()) as NSDate
        let endOfYear = Calendar.current.endOfYear(Date()) as NSDate

        let predicate = NSPredicate(format: "date >= %@ and date <= %@", startOfYear, endOfYear)

        let result = dbHelper.fetch(CashflowItemMO.self, predicate: predicate)

        switch result {
        case .success(let cashflowItems):
            return cashflowItems.map { entity in
                entity.convertToCashflowItem()
            }
        case .failure(_):
            return []
        }

    }

    func fetchFor(month: Int) -> [CashflowItem] {
        let startOfMonth = Calendar.current.startOfMonth(Date()) as NSDate
        let endOfMonth = Calendar.current.endOfMonth(Date()) as NSDate

        let predicate = NSPredicate(format: "date >= %@ and date <= %@", startOfMonth, endOfMonth)

        let result = dbHelper.fetch(CashflowItemMO.self, predicate: predicate)

        switch result {
        case .success(let cashflowItems):
            return cashflowItems.map { entity in
                entity.convertToCashflowItem()
            }
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

    private func add(_ cashflowItem: CashflowItem) {
        let entity = CashflowItemMO.entity()
        let cashflowItemMO = CashflowItemMO(entity: entity, insertInto: dbHelper.context)

        cashflowItem.uuid = UUID()
        cashflowItemMO.copyFrom(cashflowItem)

        dbHelper.create(cashflowItemMO)
    }

    private func update(for cashflowItem: CashflowItem) {
        guard let cashflowItemMO = fetchCategory(for: cashflowItem) else { return }

        cashflowItemMO.copyFrom(cashflowItem)

        dbHelper.update(cashflowItemMO)
    }
}
