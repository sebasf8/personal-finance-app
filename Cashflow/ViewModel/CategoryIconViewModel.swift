//
//  CategoryIconViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/06/2021.
//

import Foundation

protocol CategoryIconViewModel {
    var assetName: String { get }
    var colorName: String { get }
}

class CategoryIconViewModelImp: CategoryIconViewModel {
    private var category: Category

    var assetName: String
    var colorName: String

    init(_ category: Category) {
        self.category = category
        self.assetName = category.assetName
        self.colorName = category.colorName
    }
}
