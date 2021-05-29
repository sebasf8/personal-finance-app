//
//  CategoryIconView.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 07/06/2021.
//

import UIKit

class CategoryIconView: UIView {
    private var color = UIColor(named: "category_color_1")
    private var image = UIImage(named: "credit_card")

    func configure(image: UIImage?, color: UIColor?) {
        self.color = color
        self.image = image
    }

    override func layoutSubviews() {
        let imageView = UIImageView(image: image)
        imageView.tintColor = color

        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        layer.backgroundColor = color?.withAlphaComponent(0.2).cgColor

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
