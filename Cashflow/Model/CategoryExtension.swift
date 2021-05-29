//
//  CategoryExtension.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 06/06/2021.
//

import UIKit

extension Category {
    var image: UIImage? {
        return UIImage(named: assetName ?? "")
    }
}
