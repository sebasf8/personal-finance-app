//
//  CashflowItemExtension.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 29/05/2021.
//
import CoreData

extension CashflowItem {
    var type: StatementItemType? {
        get {
            guard let typeRawValue = self.typeValue else { return nil }
            return StatementItemType(rawValue: typeRawValue)
        }

        set {
            self.typeValue = newValue?.rawValue
        }
    }
}
