//
//  CategoryViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 08/06/2021.
//

import UIKit
import Combine

class CategoryListViewController: UIViewController {
    @IBOutlet private weak var categoryTable: UITableView!
    @IBOutlet private weak var categorySearch: UISearchBar!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var addCategoryButton: UIButton!

    var viewModel: CategoryListViewModel?
    private var subscriptions: Set<AnyCancellable> = []
    private var categoriesDataSource: [CategoryViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupBindings() {
        viewModel?.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.categoriesDataSource = categories
                self?.categoryTable.reloadData()
            }.store(in: &subscriptions)
    }

    private func configure() {
        titleLabel.textColor = .white
        addCategoryButton.tintColor = .white

        configureSearchView()
        configureTableView()
    }

    private func configureSearchView() {
        categorySearch.delegate = self
        categorySearch.backgroundImage = UIImage()
        categorySearch.searchTextField.backgroundColor = .white
    }

    private func configureTableView() {
        let cellView = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        categoryTable.register(cellView, forCellReuseIdentifier: "categoryCell")
        categoryTable.delegate = self
        categoryTable.dataSource = self
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? CategoryDetailViewController else {
            return
        }

        if segue.identifier == "addCategoryDetailSegue" {
            let categoryRepository = CategoryCoreDataRepository.shared
            let viewModel = CategoryViewModel(Category(name: "",
                                                       assetName: "credit_card",
                                                       colorName: "category_color_0"),
                                              repository: categoryRepository)

            viewModel.delegate = self.viewModel
            viewController.configure(viewModel: viewModel)
        } else if segue.identifier == "editCategoryDetailSegue" {
            guard let selectedRow = categoryTable.indexPathForSelectedRow?.row else {
                return
            }

            guard let viewModel = viewModel?.categories[selectedRow] else {
                return
            }

            viewController.configure(viewModel: viewModel)
        }
    }
}

// MARK: - UITableDelegate, UITableDataSource
extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        if let cell = cell as? CategoryTableViewCell {
            cell.configure(viewModel: categoriesDataSource[indexPath.row])
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)

        performSegue(withIdentifier: "editCategoryDetailSegue", sender: nil)
    }
}

// MARK: - UISearchBarDelegate
extension CategoryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterByName(searchText: searchText)
    }
}
