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
    
    @Published var currentBalance: String = "0"
    @Published var period: String = ""
    @Published var incomes: String = "0"
    @Published var expenses: String = "0"
    @Published var movements: [CashflowItemViewModel] = []

    init(repository: CashflowRepository) {
        let date = Date()

        self.repository = repository
        cashflow = repository.fetchFor(month: date.month)
        formatData(date: date)
    }

    public func reload() {
        let date = Date()
        cashflow = repository.fetchFor(month: date.month)
        formatData(date: date)
    }

    private func formatData(date: Date) {
        let balance = cashflow.currentBalance as NSNumber
        let incomes = cashflow.totalIncomes as NSNumber
        let expenses = cashflow.totalExpenses as NSNumber
        let locale = Locale.current

        currentBalance = NumberFormatters.currencyFormat(number: balance, locale: locale)
        period = DateFormatters.monthNameAndYear(date: date, locale: locale)
        self.incomes = NumberFormatters.currencyFormat(number: incomes, locale: locale)
        self.expenses =  NumberFormatters.currencyFormat(number: expenses, locale: locale)
        self.movements = cashflow.movements.map { cashflowItem in
            CashflowItemViewModel(cashflowItem)
        }
    }
}
