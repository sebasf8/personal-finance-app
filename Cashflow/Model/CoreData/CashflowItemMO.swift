//
//  CashflowItemMO+CoreDataProperties.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//
//

import Foundation
import CoreData

final class CashflowItemMO: NSManagedObject {

    @nonobjc class func fetchRequest() -> NSFetchRequest<CashflowItemMO> {
        return NSFetchRequest<CashflowItemMO>(entityName: "CashflowItemMO")
    }

    @NSManaged var uuid: UUID?
    @NSManaged var amount: Double
    @NSManaged var date: Date
    @NSManaged var name: String
    @NSManaged var typeValue: String
    @NSManaged var category: CategoryMO?

}

extension CashflowItemMO {
    func convertToCashflowItem() -> CashflowItem {
        guard let category = category else {
            fatalError()
        }

        return CashflowItem(uuid: uuid ?? UUID(),
                     name: name,
                     amount: amount,
                     date: date,
                     type: InvoiceType(rawValue: typeValue) ?? .expense,
                     category: category.convertToCategory())
    }

    func copyFrom(_ cashflowItem: CashflowItem) {
        let categoryMO = CategoryCoreDataRepository.shared.fetchCategory(for: cashflowItem.category)

        uuid = cashflowItem.uuid
        name = cashflowItem.name
        amount = cashflowItem.amount
        date = cashflowItem.date
        typeValue = cashflowItem.type.rawValue
        category = categoryMO
    }
}
