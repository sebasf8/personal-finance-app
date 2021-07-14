//
//  CashflowViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation

class CashflowViewModel {
    private let repository: CashflowRepository
    private var cashflow: CashflowModel
    private var movements: [CashflowItemViewModel] = []

    @Published var currentBalance: String = "0"
    @Published var period: String = ""
    @Published var incomes: String = "0"
    @Published var expenses: String = "0"
    @Published var movementsCount: Int = 0

    init(repository: CashflowRepository) {
        let date = Date()

        self.repository = repository
        cashflow = repository.fetchFor(month: date.month)
        bindData()
    }

    func getMovement(at index: Int) -> CashflowItemViewModel {
        movements[index]
    }

    func reload() {
        let date = Date()
        cashflow = repository.fetchFor(month: date.month)
        bindData()
    }

    private func bindData() {
        let balance = cashflow.currentBalance as NSNumber
        let incomes = cashflow.totalIncomes as NSNumber
        let expenses = cashflow.totalExpenses as NSNumber
        let locale = Locale.current

        period = cashflow.interval.description
        currentBalance = NumberFormatters.currencyFormat(number: balance, locale: locale)
        self.incomes = NumberFormatters.currencyFormat(number: incomes, locale: locale)
        self.expenses =  NumberFormatters.currencyFormat(number: expenses, locale: locale)
        self.movements = cashflow.movements.map { cashflowItem in
            return CashflowItemViewModel(cashflowItem, repository: repository.cashflowItemRepository)
        }

        movementsCount = movements.count
    }
}

extension CashflowViewModel: CashflowItemViewModelDelegate {
    func newItemAdded(_ cashflowItemViewModel: CashflowItemViewModel, cashflowItem: CashflowItem) {
        self.reload()
    }
}
