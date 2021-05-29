//
//  UIToggleButton.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 19/04/2021.
//

import UIKit

@IBDesignable
final class UIToggleButton: UIButton {
    private let color = UIColor(red: 0.153, green: 0.24, blue: 0.76, alpha: 1.0)

    override public var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = color
                tintColor = UIColor.systemBackground
            } else {
                backgroundColor = UIColor.systemBackground
                tintColor = color
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action: #selector(btnClicked(_:)),
                       for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    @objc func btnClicked (_ sender: UIButton) {
        isSelected.toggle()
    }

    func setup() {
        clipsToBounds = true
        layer.cornerRadius = 4
        tintColor = color
        layer.borderColor = color.cgColor
        layer.borderWidth = CGFloat(1.0)
        titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }

}
