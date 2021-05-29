//
//  StatementItemViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/04/2021.
//

import Foundation

class StatementsItemViewModel {
    init() {
        self.statementItem = statementItem
        name = statementItem.name
        ammount = NumberFormatters.currencyFormatter.string(from: statementItem.ammount as NSNumber)
    }
}
