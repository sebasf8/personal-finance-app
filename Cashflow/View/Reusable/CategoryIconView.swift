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
    private var viewModel: CategoryViewModel?
    private var subscriptions: Set<AnyCancellable> = []

    func configure(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        setupBindings()
    }

    func setupBindings() {
        viewModel?.$colorName.sink { [weak self] colorName in
            let color = UIColor(named: colorName)

            self?.imageView.tintColor = color
            self?.layer.backgroundColor = color?.withAlphaComponent(0.2).cgColor
        }.store(in: &subscriptions)

        viewModel?.$assetName.sink { [weak self] assetName in
            self?.imageView.image = UIImage(named: assetName)
        }.store(in: &subscriptions)
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
