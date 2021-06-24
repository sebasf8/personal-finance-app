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
    @NSManaged var categoryMO: CategoryMO?

}

extension CashflowItemMO: CashflowItem {
    var type: InvoiceType {
        get {
            InvoiceType(rawValue: typeValue) ?? .expense
        }
        set {
            typeValue = newValue.rawValue
        }
    }

    var category: Category {
        get {
            return categoryMO ?? CategoryMO(context: CoreDataStack.shared.context)
        }
        set {
            guard let category = newValue as? CategoryMO else {
                fatalError("Implementation of Category is not a Managed Object")
            }
            categoryMO = category
        }
    }
}
