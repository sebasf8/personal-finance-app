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

extension CategoryMO: Category {
    var imageName: CategoryImage {
        get {
            CategoryImage(rawValue: assetName) ?? .creditCard
        }
        set {
            assetName = newValue.rawValue
        }
    }

    var colorName: CategoryColor {
        get {
            CategoryColor(rawValue: color) ?? .gray
        }
        set {
            color = newValue.rawValue
        }
    }
}
