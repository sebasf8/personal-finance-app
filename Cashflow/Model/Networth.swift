//
//  NetworthSnapshot.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 16/04/2021.
//

import Foundation
import CoreData

class Networth {
    let container: NSPersistentContainer
    var assets: [StatementItem]
    var liabilities: [StatementItem]
    
    init(container: NSPersistentContainer ) {
        self.container = container
        
        let assetFetchRequest = NSFetchRequest<StatementItem>(entityName: "StatementItem")
        assetFetchRequest.predicate = NSPredicate(format: "typeValue == %@", StatementItemType.asset.rawValue)

        let liabilityFetchRequest = NSFetchRequest<StatementItem>(entityName: "StatementItem")
        liabilityFetchRequest.predicate = NSPredicate(format: "typeValue == %@", StatementItemType.liability.rawValue)
        
        assets = try! container.viewContext.fetch(assetFetchRequest)
        liabilities = try! container.viewContext.fetch(liabilityFetchRequest)
    }
    
    
    func addAsset(asset: StatementItem) {
        guard asset.type == .asset else {
            fatalError("StatementItem is not an asset at \(#function)")
        }
             
        addHistoryEntry(asset)
        assets.append(asset)
        try! container.viewContext.save()
    }
    
    func addLiability(liability: StatementItem) {
        guard liability.type == .liability else {
            fatalError("StatementItem is not a liability at \(#function)")
        }
        
        addHistoryEntry(liability)
        liabilities.append(liability)
        try! container.viewContext.save()
    }
    
    func getResult() -> Double {
        assets.reduce(0.0, {$0 + $1.ammount}) - liabilities.reduce(0.0, {$0 + $1.ammount})
    }
    
    // FIXME: get it to StatementItem initializer 
    private func addHistoryEntry(_ si: StatementItem) {
        let statementItemMeasure = StatementItemMeasure(context:container.viewContext)
        statementItemMeasure.ammount = si.ammount
        statementItemMeasure.date = Date()
        si.addToHistory(statementItemMeasure)
    }
    

}
