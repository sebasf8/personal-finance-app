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

protocol CashflowItem {
    var uuid: UUID? { get }
    var name: String { get set }
    var amount: Double { get set }
    var date: Date { get set }
    var type: InvoiceType { get set }
    var category: Category { get set }
}
