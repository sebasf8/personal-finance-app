//
//  CollectionViewCell.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 19/06/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedBackgroundColor = UIView(frame: bounds)
        selectedBackgroundColor.backgroundColor = .lightGray
        self.selectedBackgroundView = selectedBackgroundColor
    }

    func configure(image: UIImage) {
        self.imageView.image = image
        self.imageView.tintColor = .darkGray
    }

}
