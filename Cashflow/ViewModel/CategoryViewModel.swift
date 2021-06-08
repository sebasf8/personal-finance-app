//
//  CategoryViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 08/06/2021.
//

import Combine

protocol CategoryViewModelDelegate: AnyObject {
    func newCategoryAdded(_ categoryViewModel: CategoryViewModel)
}

class CategoryViewModel: ObservableObject, Identifiable {
    weak var delegate: CategoryViewModelDelegate?

    private var category: Category
    private let repository: CategoryRepository

    @Published var assetName: String
    @Published var colorName: String
    @Published var name: String

    init(_ category: Category, repository: CategoryRepository) {
        self.category = category
        self.repository = repository

        assetName = category.assetName
        colorName = category.colorName
        name = category.name
    }

    func nameContains(text: String ) -> Bool {
        name.lowercased().contains(text.lowercased())

    }

    func nameHasChanged(_ name: String) {
        self.name = name
        category.name = name
    }

    func changeColor(_ colorName: String) {
        self.colorName = colorName
    }

    func changeIcon(_ imageName: String) {
        assetName = imageName
    }

    func save() {
        repository.save(category)
        delegate?.newCategoryAdded(self)
    }
}
