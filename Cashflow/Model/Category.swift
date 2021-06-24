//
//  Category.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 11/06/2021.
//

import Foundation

protocol Category {
    var uuid: UUID? { get set }
    var name: String { get set }
    var imageName: CategoryImage { get set }
    var colorName: CategoryColor { get set }
}
