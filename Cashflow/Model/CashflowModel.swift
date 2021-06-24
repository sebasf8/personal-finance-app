//
//  Cashflow.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 29/05/2021.
//

import Foundation
import CoreData

struct CashflowModel {
    var movements: [CashflowItem] = []
    var totalIncomes: Double {
        sumarizeMovementsOf(type: .income)
    }
    var totalExpenses: Double {
        sumarizeMovementsOf(type: .expense)
    }

    var currentBalance: Double {
        totalIncomes - totalExpenses
    }

    init(movements: [CashflowItem]) {
        self.movements = movements
    }

    private func sumarizeMovementsOf(type: InvoiceType) -> Double {
        movements.filter { movement in
            movement.type == type
        }.reduce(0.0) { partialResult, movement in
            partialResult + movement.amount
        }
    }
}
