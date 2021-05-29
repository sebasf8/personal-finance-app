//
//  CardView.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 04/06/2021.
//
import UIKit

@IBDesignable class CardView: UIView {
    var cornnerRadius: CGFloat = 5
    var shadowOfSetWidth: CGFloat = 0
    var shadowOfSetHeight: CGFloat = 1

    var shadowColour: UIColor = .gray
    var shadowOpacity: CGFloat = 0.5

    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)

        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
