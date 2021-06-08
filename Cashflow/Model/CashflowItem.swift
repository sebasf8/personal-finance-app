//
//  CashflowItem.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//

import Foundation

enum InvoiceType: String {
    case income = "Income", expense = "Expense"
}

class CashflowItem {
    var uuid: UUID?
    var name: String
    var amount: Double
    var date: Date
    var type: InvoiceType
    var category: Category

    init(uuid: UUID? = nil, name: String, amount: Double, date: Date, type: InvoiceType, category: Category) {
        self.uuid = uuid
        self.name = name
        self.amount = amount
        self.date = date
        self.type = type
        self.category = category
    }
}
