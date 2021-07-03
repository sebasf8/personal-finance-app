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
    @IBOutlet private weak var colorDisplayView: ColorSelectionView!

    private var viewModel: CategoryViewModel?
    private var subscribers: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        setupView()
    }

    func configure(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
    }

    private func setupView() {
        configureNavigationBar()
        configureCategoryIconView()
    }

    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }

    private func configureCategoryIconView() {
        if let viewModel = viewModel {
            categoryIconView.configure(viewModel: viewModel)
        }
    }

    private func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }

        subscribers = [
            viewModel.$name.assign(to: \.text!, on: nameTextField)
        ]

        viewModel.$color.sink { [weak self] color in
            self?.colorDisplayView.configure(color: color)
        }.store(in: &subscribers)
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
        viewModel?.discardChages()
        navigationController?.popViewController(animated: true)
    }

    @objc func save() {
        viewModel?.nameHasChanged(nameTextField.text ?? "")
        viewModel?.save()
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let categoryCollectionVC as CategoryCollectionViewController:
            let collectionViewModel = CategoryImageCollectionViewModel()
            collectionViewModel.delegate = self.viewModel
            categoryCollectionVC.configure(viewModel: collectionViewModel)

        case let colorCollectionVC as ColorCollectionViewController:
            let collectionViewModel = ColorCollectionViewModel()
            collectionViewModel.delegate = self.viewModel
            colorCollectionVC.configure(viewModel: collectionViewModel)
        default:
            return
        }
    }
}
