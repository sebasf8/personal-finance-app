//
//  ColorCollectionViewCell.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/07/2021.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var colorDisplayView: ColorSelectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedBackgroundColor = UIView(frame: bounds)
        selectedBackgroundColor.backgroundColor = .lightGray
        self.selectedBackgroundView = selectedBackgroundColor
    }

    func configure(color: UIColor) {
        colorDisplayView.configure(color: color)
    }

}
