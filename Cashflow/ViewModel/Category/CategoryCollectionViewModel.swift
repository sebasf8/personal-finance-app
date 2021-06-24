//
//  CollectionViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 19/06/2021.
//

import Foundation
import UIKit.UIImage

protocol CategoryImageCollectionViewModelDelegate: AnyObject {
    func imageWasSelected(_ viewModel: CategoryImageCollectionViewModel, selectedImage: CategoryImage)
}

class CategoryImageCollectionViewModel {
    weak var delegate: CategoryImageCollectionViewModelDelegate?

    private var images = CategoryImage.allCases
    private var selected: CategoryImage?

    var numberOfElements: Int {
        images.count
    }

    func getImageFor(index: Int) -> UIImage {
        let image = UIImage(named: images[index].rawValue) ?? UIImage()
        return image
    }

    func selectImageAt(index: Int) {
        selected = images[index]
    }

    func save() {
        guard let selectedImage = selected else {
            return
        }
        delegate?.imageWasSelected(self, selectedImage: selectedImage)
    }
}
