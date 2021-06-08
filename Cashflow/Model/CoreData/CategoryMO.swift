//
//  CategoryMO.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//

import Foundation
import CoreData

final class CategoryMO: NSManagedObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CategoryMO> {
        return NSFetchRequest<CategoryMO>(entityName: "CategoryMO")
    }

    @NSManaged var uuid: UUID?
    @NSManaged var assetName: String
    @NSManaged var color: String
    @NSManaged var name: String
    @NSManaged var cashflowItem: CashflowItemMO?
}

extension CategoryMO {
    func convertToCategory() -> Category {
        Category(uuid: uuid ?? UUID(),
                 name: name,
                 assetName: assetName,
                 colorName: color)

    }

    func copyFrom(_ category: Category) {
        uuid = category.uuid
        assetName = category.assetName
        color = category.colorName
        name = category.name
    }
}
