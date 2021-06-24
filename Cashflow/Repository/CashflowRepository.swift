//
//  CashflowRepository.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation
import CoreData

protocol CashflowRepository {
    func fetch() -> CashflowModel
    func fetchFor(year: Int) -> CashflowModel
    func fetchFor(month: Int) -> CashflowModel
}

struct CashflowCoreDataRepository: CashflowRepository {
    static var shared = CashflowCoreDataRepository()

    var cashflowItemRepository: CashflowItemRepository

    private init(cashflowItemRepository: CashflowItemRepository = CashflowItemCoreDataRepository.shared) {
        self.cashflowItemRepository = cashflowItemRepository
    }

    func fetch() -> CashflowModel {
        return CashflowModel(movements: cashflowItemRepository.fetch())
    }

    func fetchFor(year: Int) -> CashflowModel {
        let movements: [CashflowItem] = cashflowItemRepository.fetchFor(year: year)
        return CashflowModel(movements: movements)
    }

    func fetchFor(month: Int) -> CashflowModel {
        let movements: [CashflowItem] = cashflowItemRepository.fetchFor(month: month)

        return CashflowModel(movements: movements)
    }
}
