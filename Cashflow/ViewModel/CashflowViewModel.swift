//
//  CashflowViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation

class CashflowViewModel {
    private let cashflow: Cashflow

    var currentBalance: String {
        formatNumberWithCurrentCurrencyLocale(cashflow.totalIncomes - cashflow.totalExpenses)
    }

    var period: String {
        DateFormatters.monthNameAndYear(date: Date(), locale: Locale.current)
    }

    var incomes: String {
        formatNumberWithCurrentCurrencyLocale(cashflow.totalIncomes)
    }

    var expenses: String {
        formatNumberWithCurrentCurrencyLocale(cashflow.totalExpenses)
    }

    var movements: [CashflowItem] {
        cashflow.movements
    }

    init(_ cashflow: Cashflow) {
        self.cashflow = cashflow
    }

    private func formatNumberWithCurrentCurrencyLocale(_ number: Double) -> String {
        NumberFormatters.currencyFormat(number: NSNumber(value: number), locale: Locale.current)
    }
}
