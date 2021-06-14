//
//  TabBarViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/06/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChilds()
    }

    private func setupChilds() {
        for viewController in children {
            let childViewController: UIViewController? = extractViewIfNavigationController(viewController)

            switch childViewController {
            case let home as HomeViewController:
                configureHome(home)
            case let categoryList as CategoryListViewController:
                configureCategoryList(categoryList)
            default:
                break
            }
        }
    }

    private func extractViewIfNavigationController(_ viewController: UIViewController) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first
        } else {
            return viewController
        }
    }

    private func configureHome(_ home: HomeViewController) {
        home.cashflowViewModel = CashflowViewModel(repository: CashflowCoreDataRepository.shared)
    }

    private func configureCategoryList (_ categoryList: CategoryListViewController) {
        categoryList.viewModel = CategoryListViewModel(repository: CategoryCoreDataRepository.shared)
    }
}
