//
//  TabBarViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 14/06/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    private var cashflowViewModel = CashflowViewModel(repository: CashflowCoreDataRepository.shared)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
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
        home.cashflowViewModel = cashflowViewModel
    }

    private func configureCategoryList (_ categoryList: CategoryListViewController) {
        categoryList.viewModel = CategoryListViewModel(repository: CategoryCoreDataRepository.shared)
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        guard viewController is NewInvoiceViewController else {
            return true
        }
        presentNewInvoice(tabBarController)
        return false
    }

    private func presentNewInvoice(_ tabBarController: UITabBarController) {
        let invoiceViewController = storyboard?.instantiateViewController(withIdentifier: "NewInvoiceViewController")

        if  let invoiceViewController = invoiceViewController as? NewInvoiceViewController {
            let repository = CashflowItemCoreDataRepository.shared
            let cashflowItemViewModel = CashflowItemViewModel(repository.make(), repository: repository)
            cashflowItemViewModel.delegate = cashflowViewModel
            invoiceViewController.viewModel = cashflowItemViewModel

            tabBarController.present(invoiceViewController, animated: true)
        }
    }
}
