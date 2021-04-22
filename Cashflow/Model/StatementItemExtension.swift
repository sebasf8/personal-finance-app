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
            if let typeRawValue = self.typeValue {
                return StatementItemType(rawValue: typeRawValue)
            }
            return nil
        }
        
        set {
            self.typeValue = newValue?.rawValue
            
        }
    }
    
    public func addHistoryEntry(ammount: Double, date: Date) {
        guard let context = self.managedObjectContext else{
            fatalError("no context was setted")
        }
        
        let statementItemMeasure = StatementItemMeasure(context: context)
        statementItemMeasure.ammount = ammount
        statementItemMeasure.date = date
        self.addToHistory(statementItemMeasure)
    }

}
