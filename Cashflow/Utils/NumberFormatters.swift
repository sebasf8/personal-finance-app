//
//  NumberFormatters.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/04/2021.
//

import Foundation

struct NumberFormatters {
    static let currencyFormatter: NumberFormatter = {
        let locale = Locale.current
        var formatter = NumberFormatter()
        
        formatter.currencySymbol = locale.currencySymbol
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        
        return formatter
    }()
}
