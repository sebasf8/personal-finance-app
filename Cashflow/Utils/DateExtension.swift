//
//  DateExtension.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 29/05/2021.
//

import Foundation
extension Date {
    var year: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year!
    }

    var month: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month!
    }
}
