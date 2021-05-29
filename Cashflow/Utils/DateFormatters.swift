//
//  DateFormatters.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 31/05/2021.
//

import Foundation

struct DateFormatters {
    static func monthNameAndYear(date: Date, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")

        return dateFormatter.string(from: date)
    }

    static func dayMonthAndYear(date: Date, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: date)
    }

}
