//
//  CategoryIconView.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 07/06/2021.
//

import UIKit
import Combine

class CategoryIconView: UIView {
    private var imageView = UIImageView()
    private var viewModel: CategoryIconViewModel?

    func configure(viewModel: CategoryIconViewModel) {
        self.viewModel = viewModel

        let color = UIColor(named: viewModel.colorName)
        imageView.tintColor = color
        imageView.image = UIImage(named: viewModel.assetName)
        layer.backgroundColor = color?.withAlphaComponent(0.2).cgColor

    }

    override func layoutSubviews() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true

        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
