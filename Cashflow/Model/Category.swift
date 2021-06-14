//
//  Category.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//

import Foundation

class Category {
    var uuid: UUID?
    var name: String
    var assetName: String
    var colorName: String

    init(uuid: UUID? = nil, name: String, assetName: String, colorName: String) {
        self.uuid = uuid
        self.name = name
        self.assetName = assetName
        self.colorName = colorName
    }
}
