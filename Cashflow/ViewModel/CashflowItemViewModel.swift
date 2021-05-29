//
//  CashflowItemViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import UIKit

class CashflowItemViewModel {
    private let cashflowItem: CashflowItem

    var name: String? {
        cashflowItem.name
    }

    var amount: String {
        makeFormattedAmount()
    }

    var amountLabelColor: UIColor? {
        getLabelColor()
    }

    var date: String {
        formatDate()
    }

    var categoryImage: UIImage? {
        guard let assetName = cashflowItem.category?.assetName else {
            return nil
        }

        return UIImage(named: assetName)
    }

    var categoryColor: UIColor? {
        guard let colorName = cashflowItem.category?.color else {
            return UIColor(named: "category_color_1")
        }

        return UIColor(named: colorName)
    }

    init(_ cashflowItem: CashflowItem) {
        self.cashflowItem = cashflowItem
    }

    private func makeFormattedAmount() -> String {
        var sign = ""
        let amount = NumberFormatters.currencyFormat(number: cashflowItem.amount as NSNumber, locale: Locale.current)
        if cashflowItem.type == .expense {
            sign = "-"
        }

        return "\(sign)\(amount)"
    }

    private func getLabelColor() -> UIColor? {
        if cashflowItem.type == .expense {
            return UIColor(named: "expense_color")
        } else {
            return UIColor(named: "income_color")
        }
    }

    private func formatDate() -> String {
        var dateText = ""

        if let date = cashflowItem.date {
            dateText = DateFormatters.dayMonthAndYear(date: date, locale: Locale.current)
        }
        return dateText
    }
}
