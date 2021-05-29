//
//  Cashflow.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 29/05/2021.
//

import Foundation
import CoreData

class Cashflow {
    var movements: [CashflowItem] = []
    var totalIncomes: Double {
        sumarizeMovementsOf(type: .income)
    }
    var totalExpenses: Double {
        sumarizeMovementsOf(type: .expense)
    }

    init(movements: [CashflowItem]) {
        self.movements = movements
    }

    func registerExpense(_ expense: CashflowItem) {
        movements.append(expense)
    }

    func registerIncome(_ income: CashflowItem) {
        movements.append(income)
    }

    private func sumarizeMovementsOf(type: StatementItemType) -> Double {
        movements.filter { movement in
            movement.type == type
        }.reduce(0.0) { partialResult, movement in
            partialResult + movement.amount
        }
    }
}
