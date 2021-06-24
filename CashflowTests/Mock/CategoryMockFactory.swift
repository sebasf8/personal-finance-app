//
//  CategoryMockFactory.swift
//  CashflowTests
//
//  Created by Sebastian Fernandez on 24/06/2021.
//

import Foundation
@testable import Cashflow

enum CategoryMockType {
    case fuel, creditCard, salary
}

struct CategoryMock: Cashflow.Category {
    var uuid: UUID?
    var name: String
    var imageName: CategoryImage
    var colorName: CategoryColor
}

struct CategoryMockFactory {
    func make(categoryType: CategoryMockType) -> Cashflow.Category {
        switch categoryType {
        case .fuel:
            return CategoryMock(uuid: UUID(),
                                name: "Fuel",
                                imageName: .fuel,
                                colorName: .purple)
        case .creditCard:
            return CategoryMock(uuid: UUID(),
                                name: "Credit Card",
                                imageName: .creditCard,
                                colorName: .red)
        case .salary:
            return CategoryMock(uuid: UUID(),
                                name: "Salary",
                                imageName: .creditCard,
                                colorName: .green)
        }
    }
}
