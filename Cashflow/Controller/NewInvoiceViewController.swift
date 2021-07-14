//
//  NewInvoiceViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 04/07/2021.
//

import UIKit

class NewInvoiceViewController: UIViewController {
    @IBOutlet weak private var nameInput: UITextField!
    @IBOutlet weak private var amountInput: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var invoiceType: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryIconView: CategoryIconView!

    var viewModel: CashflowItemViewModel?
    private let invoiceTypes = InvoiceType.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInvoiceTypesSelector()
        configureSaveButton()
    }

    private func configureInvoiceTypesSelector() {
        for index in (0..<invoiceTypes.count) {
            invoiceType.setTitle(invoiceTypes[index].rawValue.capitalized, forSegmentAt: index)
        }
    }

    private func configureSaveButton() {
        saveButton.layer.cornerRadius = 4
    }

    @IBAction func invoiceTypeSelected(_ sender: UISegmentedControl) {

    }

    @IBAction func save(_ sender: Any) {
        self.view.endEditing(true)
        if let amount = amountInput.text {
            viewModel?.cashflowItem.amount = Double(amount) ?? 0
        }

        viewModel?.cashflowItem.name = nameInput.text ?? ""
        viewModel?.cashflowItem.date = datePicker.date
        viewModel?.cashflowItem.type = invoiceTypes[invoiceType.selectedSegmentIndex]

        viewModel?.save()

        self.dismiss(animated: true, completion: nil)
        clearInputs()
    }

    private func clearInputs() {
        nameInput.text = ""
        amountInput.text = ""
        datePicker.date = Date()
    }
}
