//
//  CategoryDetailViewTableViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 09/06/2021.
//

import UIKit
import Combine

enum RowField: Int {
    case name = 0, icon = 1, color = 2
}

class CategoryDetailViewController: UITableViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var categoryIconView: CategoryIconView!
    @IBOutlet private weak var colorDisplayView: UIView!

    private var viewModel: CategoryViewModel?
    private var subscribers: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        setupView()
    }

    private func setupView() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton

    }

    func configure(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
    }

    private func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }

        subscribers = [
            viewModel.$name.assign(to: \.text!, on: nameTextField)
        ]

        categoryIconView.configure(viewModel: viewModel)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch RowField(rawValue: indexPath.row) {
        case .name:
            nameTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
    }

    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }

    @objc func save() {
        viewModel?.nameHasChanged(nameTextField.text ?? "")

        viewModel?.save()
        navigationController?.popViewController(animated: true)

    }
}
