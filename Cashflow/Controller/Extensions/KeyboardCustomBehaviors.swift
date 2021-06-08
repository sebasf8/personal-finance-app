//
//  KeyboardCustomBehaivors.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 15/04/2021.
//

import UIKit
import SwiftUI

extension UIViewController {
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
