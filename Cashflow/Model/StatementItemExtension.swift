//
//  StatementItemExtension.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 18/04/2021.
//

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

}
