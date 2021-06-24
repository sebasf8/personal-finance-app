//
//  CashflowViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation

class CashflowViewModel {
    private let cashflow: CashflowModel
    private let repository: CashflowRepository

    @Published var currentBalance: String
    @Published var period: String
    @Published var incomes: String
    @Published var expenses: String
    @Published var movements: [CashflowItemViewModel]

    init(repository: CashflowRepository) {
        let date = Date()
        self.repository = repository
        self.cashflow = repository.fetchFor(month: date.month)

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
