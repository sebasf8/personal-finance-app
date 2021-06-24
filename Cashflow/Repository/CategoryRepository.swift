//
//  CategoryRepository.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 08/06/2021.
//

import Foundation
import CoreData

protocol CategoryRepository {
    func fetch() -> [Category]
    func save(_ category: Category)
    func make() -> Category
}

class CategoryCoreDataRepository {
    static let shared: CategoryCoreDataRepository = CategoryCoreDataRepository()

    var dbHelper: CoreDataStack = CoreDataStack.shared

    private init() { }

    func fetchCategory(for category: Category) -> CategoryMO? {
        guard let uuid = category.uuid else { return nil }

        let predicate = NSPredicate(
            format: "uuid = %@",
            uuid as CVarArg)

        let result = dbHelper.fetchFirst(CategoryMO.self, predicate: predicate)
        switch result {
        case .success(let categoryMO):
            return categoryMO
        case .failure(_):
            return nil
        }
    }
}

extension CategoryCoreDataRepository: CategoryRepository {
    func fetch() -> [Category] {
        let result = dbHelper.fetch(CategoryMO.self)

        switch result {
        case .success(let categories):
            return categories
        case .failure(_):
            return []
        }
    }

    func save(_ category: Category) {
        if category.uuid != nil {
            update(for: category)
        } else {
            add(category)
        }
    }

    private func add(_ category: Category) {
        guard let categoryMO = category as? CategoryMO else {
            fatalError("Implementation of Category is not a Managed Object")
        }
        categoryMO.uuid = UUID()
        dbHelper.create(categoryMO)
    }

    private func update(for category: Category) {
        guard let categoryMO = category as? CategoryMO else {
            fatalError("Implementation of Category is not a Managed Object")
        }
        dbHelper.update(categoryMO)
    }

    func make() -> Category {
        let entity = CategoryMO.entity()
        return CategoryMO(entity: entity, insertInto: dbHelper.context)
    }
}
