//
//  CategoryViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 08/06/2021.
//

import Combine
import UIKit.UIColor

protocol CategoryViewModelDelegate: AnyObject {
    func needsRefresh(_ categoryViewModel: CategoryViewModel)
}

class CategoryViewModel: ObservableObject {
    weak var delegate: CategoryViewModelDelegate?

    private var category: Category
    private let repository: CategoryRepository
    private var selectedImage: CategoryImage?
    private var selectedColor: CategoryColor?

    @Published var assetName: String
    @Published var color: UIColor
    @Published var name: String

    init(_ category: Category,
         repository: CategoryRepository = CategoryCoreDataRepository.shared) {
        self.category = category
        self.repository = repository

        assetName = category.imageName.rawValue
        color = UIColor(named: category.colorName.rawValue) ?? .gray
        name = category.name
    }

    func nameContains(text: String ) -> Bool {
        name.lowercased().contains(text.lowercased())
    }

    func nameHasChanged(_ name: String) {
        self.name = name
        category.name = name
    }

    func save() {
        if let imageSelected = selectedImage {
            category.imageName = imageSelected
        }
        if let colorSelected = selectedColor {
            category.colorName = colorSelected
        }

        repository.save(category)
        delegate?.needsRefresh(self)
    }

    func discardChages() {
        assetName = category.imageName.rawValue
        color = UIColor(named: category.colorName.rawValue) ?? .gray
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

// MARK: - ColorCollectionViewModelDelegate
extension CategoryViewModel: ColorCollectionViewModelDelegate {
    func colorWasSelected(_ viewModel: ColorCollectionViewModel, selectedColor: CategoryColor) {
        self.selectedColor = selectedColor
        color = UIColor(named: selectedColor.rawValue) ?? .gray
    }
}
