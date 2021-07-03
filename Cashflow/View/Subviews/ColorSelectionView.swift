//
//  ColorSelectionView.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/06/2021.
//

import UIKit

class ColorSelectionView: UIView {
    func configure(color: UIColor) {
        self.backgroundColor = color
    }

    override func layoutSubviews() {
        layer.cornerRadius = 6
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2

        addShadow()
    }

}
