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

        asset.addHistoryEntry(amount: asset.amount, date: Date())
        assets.append(asset)

        try repository.save(asset)
    }

    func addLiability(liability: StatementItem) throws {
        guard liability.type == .liability else {
            fatalError("StatementItem is not a liability at \(#function)")
        }

        liability.addHistoryEntry(amount: liability.amount, date: Date())
        liabilities.append(liability)

        try repository.save(liability)
    }

    func getResult() -> Double {
        assets.reduce(0.0, {$0 + $1.amount}) - liabilities.reduce(0.0, {$0 + $1.amount})
    }

    func getDayGroupedHistory(since: Date, until: Date) -> [(Date, Double)] {
        var networthHistory = [Date: Double]()

        for asset in assets {
            _ = asset.getHistory(since: since, until: until).map { entry in

                if let logDate = entry.date, let registry = networthHistory[logDate] {
                    networthHistory[Calendar.current.startOfDay(for: logDate)] = registry + entry.ammount
                } else {
                    networthHistory[Calendar.current.startOfDay(for: entry.date!)] = entry.ammount
                }
            }
        }

        for liability in liabilities {
            _ = liability.getHistory(since: since, until: until).map { entry in
                if let logDate = entry.date, let registry = networthHistory[logDate] {
                    networthHistory[Calendar.current.startOfDay(for: logDate)] = registry - entry.ammount
                } else {
                    networthHistory[Calendar.current.startOfDay(for: entry.date!)] = -entry.ammount
                }
            }
        }

        return networthHistory.sorted { (arg0, arg1) -> Bool in
            let (key2, _) = arg1
            let (key1, _) = arg0

            return key1 < key2
        }
    }

}
