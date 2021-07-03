//
//  UIVIewExtension.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/07/2021.
//

import UIKit

extension UIView {
    func addShadow(shadowOffset: CGSize = CGSize(width: 1, height: 2),
                   shadowColor: UIColor = .black,
                   shadowOpacity: CGFloat = 0.5) {

        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)

        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }

}
