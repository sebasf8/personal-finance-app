//
//  CashflowItemViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation

class CashflowItemViewModel {
    private let cashflowItem: CashflowItem

    var name: String {
        cashflowItem.name
    }

    var amount: String {
        makeFormattedAmount()
    }

    var amountLabelColor: String {
        getLabelColor()
    }

    var date: String {
        formatDate()
    }

    var category: CategoryViewModel

    init(_ cashflowItem: CashflowItem) {
        self.cashflowItem = cashflowItem
        category = CategoryViewModel(cashflowItem.category)
    }

    private func makeFormattedAmount() -> String {
        var sign = ""
        let amount = NumberFormatters.currencyFormat(number: cashflowItem.amount as NSNumber, locale: Locale.current)
        if cashflowItem.type == .expense {
            sign = "-"
        }

        return "\(sign)\(amount)"
    }

    private func getLabelColor() -> String {
        if cashflowItem.type == .expense {
            return "expense_color"
        } else {
            return "income_color"
        }
    }

    private func formatDate() -> String {
        return DateFormatters.dayMonthAndYear(date: cashflowItem.date, locale: Locale.current)
    }
}
