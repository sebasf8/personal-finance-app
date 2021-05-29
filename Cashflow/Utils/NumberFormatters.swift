//
//  NumberFormatters.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/04/2021.
//

import Foundation

struct NumberFormatters {
    static func currencyFormat(number: NSNumber, locale: Locale) -> String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = locale.currencySymbol
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency

        return formatter.string(from: number) ?? ""
    }
}
