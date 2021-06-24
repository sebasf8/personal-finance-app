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

class CategoryViewModel: ObservableObject {
    weak var delegate: CategoryViewModelDelegate?

    private var category: Category
    private let repository: CategoryRepository
    private var selectedImage: CategoryImage?

    @Published var assetName: String
    @Published var colorName: String
    @Published var name: String

    init(_ category: Category,
         repository: CategoryRepository = CategoryCoreDataRepository.shared) {
        self.category = category
        self.repository = repository

        assetName = category.imageName.rawValue
        colorName = category.colorName.rawValue
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
        if let imageSelected = selectedImage {
            category.imageName = imageSelected
        }

        repository.save(category)
        delegate?.newCategoryAdded(self)
    }

    func discardChages() {
        loadDataFromModel()
    }

    private func loadDataFromModel() {
        assetName = category.imageName.rawValue
        colorName = category.colorName.rawValue
        name = category.name
    }
}

// MARK: - CategoryImageCollectionViewModelDelegate
extension CategoryViewModel: CategoryImageCollectionViewModelDelegate {
    func imageWasSelected(_ viewModel: CategoryImageCollectionViewModel, selectedImage: CategoryImage) {
        self.selectedImage = selectedImage
        assetName = selectedImage.rawValue
    }
}
