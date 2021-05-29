//
//  PopupPickerView.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 15/04/2021.
//

import UIKit

func showPickerViewPopup(width popupWidth: Float, height popupHeight: Float) {
    let vieController = UIViewController()
    vieController.preferredContentSize = CGSize(width: popupWidth, height: popupHeight)

    let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: width, height: height))

    pickerView.delegate = self
    pickerView.dataSource = self

    pickerView.selectRow(categorySelectedRow, inComponent: 0, animated: true)

    vc.view.addSubview(pickerView)
    pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
    pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

    let alert = UIAlertController(title: "Category", message: nil, preferredStyle: .actionSheet)

    alert.popoverPresentationController?.sourceView = categoryPickerButton
    alert.popoverPresentationController?.sourceRect = categoryPickerButton.bounds

    alert.setValue(vc, forKey: "contentViewController")

    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

    alert.addAction(UIAlertAction(title: "Select", style: .default, handler: {_ in
        self.categorySelectedRow = pickerView.selectedRow(inComponent: 0)
        self.selectedCategory = self.assetCategories[self.categorySelectedRow]
        self.categoryPickerButton.setTitle(self.selectedCategory, for: .normal)
    }))

    self.present(alert, animated: true, completion: nil)
}

@objc func saveStatement() {
    let statementItem = StatementItem(context: container!.viewContext)

    statementItem.name = nameTextInput.text
    statementItem.ammount = Double(ammountTextInput.text ?? "0.00")!
    statementItem.date = Date()
    statementItem.type = StatementItemType.asset.rawValue
    statementItem.category = selectedCategory
    do {
        try container?.viewContext.save()

        } catch {
            fatalError()
        }

        navigationController?.popViewController(animated: true)
    }
