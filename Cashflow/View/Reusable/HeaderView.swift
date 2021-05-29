//
//  HeaderView.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 30/05/2021.
//

import UIKit

class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       customize()
    }

    private func customize() {
        self.setBackgroundColor()
    }

    private func setBackgroundColor() {
        let colorTop = UIColor(red: 89 / 255.0, green: 54 / 255.0, blue: 186 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 141.0 / 255.0, green: 78 / 255.0, blue: 213 / 255.0, alpha: 1.0).cgColor

        let backgroundColor = CAGradientLayer()
        backgroundColor.colors = [colorTop, colorBottom]
        backgroundColor.locations = [0.0, 0.4]

        self.backgroundColor = UIColor.clear
        let backgroundLayer = backgroundColor
        backgroundLayer.frame = self.frame
        self.layer.insertSublayer(backgroundLayer, at: 0)
    }
}
