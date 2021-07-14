//
//  CashflowItemViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/06/2021.
//

import Foundation

protocol CashflowItemViewModelDelegate: AnyObject {
    func newItemAdded(_ cashflowItemViewModel: CashflowItemViewModel, cashflowItem: CashflowItem)
}

class CashflowItemViewModel: ObservableObject {
    @Published var cashflowItem: CashflowItem
    weak var delegate: CashflowItemViewModelDelegate?
    private let repository: CashflowItemRepository

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

    init(_ cashflowItem: CashflowItem, repository: CashflowItemRepository) {
        self.cashflowItem = cashflowItem
        self.repository = repository
        category = CategoryViewModel(cashflowItem.category)
    }

    func save() {
        repository.save(cashflowItem)
        delegate?.newItemAdded(self, cashflowItem: cashflowItem)
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
            return InvoiceColor.expense.rawValue
        } else {
            return InvoiceColor.income.rawValue
        }
    }

    private func formatDate() -> String {
        return DateFormatters.dayMonthAndYear(date: cashflowItem.date, locale: Locale.current)
    }
}
