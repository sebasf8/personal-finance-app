//
//  CashflowRepository.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation
import CoreData

protocol CashflowRepository {
    func fetch() -> Cashflow
    func fetchFor(year: Int) -> Cashflow
    func fetchFor(month: Int) -> Cashflow
}

struct CashflowCoreDataRepository: CashflowRepository {
    static var shared = CashflowCoreDataRepository()

    var cashflowItemRepository: CashflowItemRepository

    private init(cashflowItemRepository: CashflowItemRepository = CashflowItemCoreDataRepository.shared) {
        self.cashflowItemRepository = cashflowItemRepository
    }

    func fetch() -> Cashflow {
        return Cashflow(movements: cashflowItemRepository.fetch())
    }

    func fetchFor(year: Int) -> Cashflow {
        let movements: [CashflowItem] = cashflowItemRepository.fetchFor(year: year)
        return Cashflow(movements: movements)
    }

    func fetchFor(month: Int) -> Cashflow {
        let movements: [CashflowItem] = cashflowItemRepository.fetchFor(month: month)

        return Cashflow(movements: movements)
    }
}
