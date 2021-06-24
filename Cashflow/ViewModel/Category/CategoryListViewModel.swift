//
//  CategoryListViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 08/06/2021.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    private var categoriesCached: [CategoryViewModel]
    @Published var categories: [CategoryViewModel]

    init(repository: CategoryRepository) {
        let categories = repository.fetch().map { category in
            CategoryViewModel(category, repository: repository)
        }

        self.categories = categories
        categoriesCached = categories
    }

    func filterByName(searchText: String) {
        if searchText != "" {
            categories = categoriesCached.filter { category in
                category.nameContains(text: searchText)
            }
        } else {
            categories = categoriesCached
        }
    }
}

extension CategoryListViewModel: CategoryViewModelDelegate {
    func newCategoryAdded(_ categoryViewModel: CategoryViewModel) {
        categoriesCached.append(categoryViewModel)
        categories.append(categoryViewModel)
    }
}
