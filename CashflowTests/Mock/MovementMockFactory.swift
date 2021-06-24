//
//  MovementMockFactory.swift
//  CashflowTests
//
//  Created by Sebastian Fernandez on 24/06/2021.
//

import Foundation
@testable import Cashflow

enum MovementMockType {
    case salary, rent, fuel
}

struct MovementMock: CashflowItem {
    var uuid: UUID?
    var name: String
    var amount: Double
    var date: Date
    var type: InvoiceType
    var category: Cashflow.Category
}

struct MovementMockFactory {
    let categoryFactory = CategoryMockFactory()

    func make(_ movementMockType: MovementMockType, date: Date) -> CashflowItem {
        switch movementMockType {
        case .salary:
            let salary = categoryFactory.make(categoryType: .salary)
            return MovementMock(uuid: nil,
                         name: "Salary",
                         amount: 1200,
                         date: date,
                         type: .income,
                         category: salary)
        case .rent:
            let creditCard = categoryFactory.make(categoryType: .creditCard)
            return MovementMock(uuid: nil,
                         name: "Rent",
                         amount: 900,
                         date: date,
                         type: .expense,
                         category: creditCard)
        case .fuel:
            let fuel = categoryFactory.make(categoryType: .fuel)
            return MovementMock(name: "Fuel",
                         amount: 17.5,
                         date: date,
                         type: .expense,
                         category: fuel)
        }
    }
}
