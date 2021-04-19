//
//  UIToggleButton.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 19/04/2021.
//

import UIKit

@IBDesignable
final class UIToggleButton: UIButton {
    private let color = UIColor(red: CGFloat(39.0/255), green: CGFloat(62.0/255), blue: CGFloat(194.0/255), alpha: CGFloat(1.0))

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
    
    @objc func btnClicked (_ sender:UIButton) {
        isSelected.toggle()
    }

    func setup() {
        clipsToBounds = true
        layer.cornerRadius = 4
        tintColor = color
        layer.borderColor = color.cgColor
        layer.borderWidth = CGFloat(1.0)
        titleEdgeInsets = UIEdgeInsets(top: CGFloat(5), left: CGFloat(5), bottom: CGFloat(5), right: CGFloat(5))
    }
    
}
