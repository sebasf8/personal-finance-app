//
//  NetworthSnapshot.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 16/04/2021.
//

import Foundation
import CoreData

class Networth {
    let repository: StatementItemRepository
    var assets: [StatementItem]
    var liabilities: [StatementItem]
    
    init(repository: StatementItemRepository) {
        self.repository = repository
        
        let assetsRes = try? repository.findByParameters(params: StatementItemParameters(type: .asset))
        let liabilitiesRes = try? repository.findByParameters(params: StatementItemParameters(type: .liability))
        
        assets = assetsRes ?? []
        liabilities = liabilitiesRes ?? []

    }
    
    
    func addAsset(asset: StatementItem) throws {
        guard asset.type == .asset else {
            fatalError("StatementItem is not an asset at \(#function)")
        }
             
        asset.addHistoryEntry(ammount: asset.ammount, date: Date())
        assets.append(asset)
        
        try repository.save(asset)
    }
    
    func addLiability(liability: StatementItem) throws {
        guard liability.type == .liability else {
            fatalError("StatementItem is not a liability at \(#function)")
        }
        
        liability.addHistoryEntry(ammount: liability.ammount, date: Date())
        liabilities.append(liability)
        
        try repository.save(liability)
    }
    
    func getResult() -> Double {
        assets.reduce(0.0, {$0 + $1.ammount}) - liabilities.reduce(0.0, {$0 + $1.ammount})
    }
    

}
