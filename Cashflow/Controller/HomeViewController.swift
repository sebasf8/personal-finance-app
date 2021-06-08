//
//  HomeViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 30/05/2021.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    @IBOutlet weak private var currentBalanceLabel: UILabel!
    @IBOutlet weak private var periodButton: UIButton!
    @IBOutlet weak private var incomeInPeriodLabel: UILabel!
    @IBOutlet weak private var expenseInPeriodLabel: UILabel!
    @IBOutlet weak private var movementsTable: UITableView!

    private let movementCellId = "movementCell"
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    private var cashflowViewModel: CashflowViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        configureHeader()
        configureMovementsTable()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Setup
    private func configureHeader() {
        currentBalanceLabel.text = cashflowViewModel?.currentBalance
        periodButton.setTitle(cashflowViewModel?.period, for: .normal)
        incomeInPeriodLabel.text = cashflowViewModel?.incomes
        expenseInPeriodLabel.text = cashflowViewModel?.expenses
    }

    private func configureMovementsTable() {
        let cellView = UINib(nibName: "MovementTableViewCell", bundle: nil)
        movementsTable.delegate = self
        movementsTable.dataSource = self
        movementsTable.rowHeight = UITableView.automaticDimension
        movementsTable.estimatedRowHeight = 100
        movementsTable.register(cellView, forCellReuseIdentifier: movementCellId)
    }

    @IBAction func periodTapped(_ sender: Any) {
        presentPeriodPickerView()
    }

    private func loadData() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//
//        let date1 = formatter.date(from: "2021/06/29 22:31")!
//        let date2 = formatter.date(from: "2021/06/28 22:31")!
//        let date3 = formatter.date(from: "2021/03/29 22:31")!
//        let date4 = formatter.date(from: "2021/06/29 22:31")!
//
//        let category1 = Category(name: "Fuel",
//                                 assetName: "Fuel",
//                                 colorName: "category_color_1")
//
//        let category2 = Category(name: "Credit Card",
//                                 assetName: "credit_card",
//                                 colorName: "category_color_2")
//
//        let category3 = Category(name: "Dinner",
//                                 assetName: "dinner",
//                                 colorName: "category_color_3")
//
//        let category4 = Category(name: "Salary",
//                                 assetName: "credit_card",
//                                 colorName: "category_color_1")
//
//        let income1 = CashflowItem(uuid: nil,
//                                   name: "Salary",
//                                   amount: 1200,
//                                   date: date1,
//                                   type: .income,
//                                   category: category4)
//
//        let expense1 = CashflowItem(uuid: nil,
//                                    name: "Rent",
//                                    amount: 900,
//                                    date: date2,
//                                    type: .expense,
//                                    category: category2)
//
//        let expense2 = CashflowItem(uuid: nil,
//                                    name: "Food",
//                                    amount: 200,
//                                    date: date3,
//                                    type: .expense,
//                                    category: category3)
//
//        let expense3 = CashflowItem(name: "Fuel",
//                                    amount: 17.5,
//                                    date: date4,
//                                    type: .expense,
//                                    category: category1)

        let itemRepository = CashflowItemCoreDataRepository.shared
        let repository = CashflowCoreDataRepository(cashflowItemRepository: itemRepository)

//        categoryRepository.save(category1)
//        categoryRepository.save(category2)
//        categoryRepository.save(category3)
//        categoryRepository.save(category4)
//
//        itemRepository.save(income1)
//        itemRepository.save(expense1)
//        itemRepository.save(expense2)
//        itemRepository.save(expense3)

        cashflowViewModel = CashflowViewModel(repository: repository)

//        let movementsViewModel: [CashflowItemViewModel] = cashflow.movements.map { cashflowItem in
//            let categoryViewModel = CategoryViewModel(repository: categoryRepository)
//
//            return CashflowItemViewModel(cashflowItem, category: categoryViewModel, repository: repository)
//        }

    }

    // MARK: - Navigation
    private func presentPeriodPickerView() {
        print("Present period selection view")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cashflowViewModel?.movements.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movementCellId, for: indexPath)

        if let cell = cell as? MovementTableViewCell, let viewModel = cashflowViewModel {
            let movement = viewModel.movements[indexPath.row]
            cell.configure(movement: movement)
        }

        return cell
    }
}
