//
//  StatementItemExtension.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 18/04/2021.
//
import CoreData

extension StatementItem {
    var type: StatementItemType? {
        get {
            guard let typeRawValue = self.typeValue else { return nil }
            return StatementItemType(rawValue: typeRawValue)
        }

        set {
            self.typeValue = newValue?.rawValue

        }
    }

    public func addHistoryEntry(amount: Double, date: Date) {
        guard let context = self.managedObjectContext else {
            fatalError("no context was setted")
        }

        let statementItemMeasure = StatementItemMeasure(context: context)
        statementItemMeasure.ammount = amount
        statementItemMeasure.date = date
        self.addToHistory(statementItemMeasure)
    }

    public func getHistory(since: Date, until: Date) -> [StatementItemMeasure] {
        if let history = history as? Set<StatementItemMeasure> {
            return history.filter {
                let historyDate = Calendar.current.startOfDay(for: $0.date!)
                let fromDate: Date = Calendar.current.startOfDay(for: since)
                let toDate: Date = Calendar.current.startOfDay(for: until)

                return historyDate >= fromDate && historyDate <= toDate
            }.sorted(by: {$0.date! < $1.date!})
        } else {
            return []
        }
    }

}
