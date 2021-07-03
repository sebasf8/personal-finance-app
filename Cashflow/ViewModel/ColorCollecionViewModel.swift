//
//  ColorCollecionViewModel.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/07/2021.
//

import Foundation
import UIKit.UIColor

protocol ColorCollectionViewModelDelegate: AnyObject {
    func colorWasSelected(_ viewModel: ColorCollectionViewModel, selectedColor: CategoryColor)
}

class ColorCollectionViewModel {
    weak var delegate: ColorCollectionViewModelDelegate?

    private var colors = CategoryColor.allCases
    private var selected: CategoryColor?

    var numberOfElements: Int {
        colors.count
    }

    func getColorFor(index: Int) -> UIColor {
        let color = UIColor(named: colors[index].rawValue) ?? .gray
        return color
    }

    func selectColorAt(index: Int) {
        selected = colors[index]
    }

    func save() {
        guard let selectedColor = selected else {
            return
        }

        delegate?.colorWasSelected(self, selectedColor: selectedColor)
    }
}
