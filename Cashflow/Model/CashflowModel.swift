//
//  Cashflow.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 29/05/2021.
//

import Foundation
import CoreData

struct CashflowModel {
    var movements: [CashflowItem] = []
    var interval: DateInterval

    var totalIncomes: Double {
        sumarizeMovementsOf(type: .income)
    }
    var totalExpenses: Double {
        sumarizeMovementsOf(type: .expense)
    }

    var currentBalance: Double {
        totalIncomes - totalExpenses
    }

    private func sumarizeMovementsOf(type: InvoiceType) -> Double {
        movements.filter { movement in
            movement.type == type
        }.reduce(0.0) { partialResult, movement in
            partialResult + movement.amount
        }
    }
}

enum DateInterval {
    case all
    case month(Int)
    case year(Int)
    case range(Date, Date)
}

extension DateInterval: CustomStringConvertible {
    var description: String {
        switch self {
        case .all:
            return "All"
        case .month(let month):
            return "\(formatDateToMonth(month: month))"
        case .year(_):
            fatalError("Not implemented")
        case .range(let since, let until):
            let formattedFromDate = DateFormatters.monthNameAndYear(date: since, locale: Locale.current)
            let formattedToDate = DateFormatters.monthNameAndYear(date: until, locale: Locale.current)
            return "From \(formattedFromDate) to \(formattedToDate)"
        }
    }

    private func formatDateToMonth(month: Int) -> String {
        let now = Date()
        guard let dateWithMonthCalculated = Calendar.current.date(bySetting: .month, value: month, of: now) else {
            return  ""
        }

        return DateFormatters.monthNameAndYear(date: dateWithMonthCalculated, locale: Locale.current)
    }
}
