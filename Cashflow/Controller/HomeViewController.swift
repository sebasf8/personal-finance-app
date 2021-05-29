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

    // swiftlint:disable force_cast
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast

    private var cashflowViewModel: CashflowViewModel!

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
        currentBalanceLabel.text = cashflowViewModel.currentBalance
        periodButton.setTitle(cashflowViewModel.period, for: .normal)
        incomeInPeriodLabel.text = cashflowViewModel.incomes
        expenseInPeriodLabel.text = cashflowViewModel.expenses
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

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let date1 = formatter.date(from: "2021/06/29 22:31")
        let date2 = formatter.date(from: "2021/06/28 22:31")
        let date3 = formatter.date(from: "2021/03/29 22:31")
        let date4 = formatter.date(from: "2021/06/29 22:31")

        let category1 = Category(context: context)
        category1.assetName = "fuel"
        category1.name = "Fuel"
        category1.color = "category_color_1"

        let category2 = Category(context: context)
        category2.assetName = "credit_card"
        category2.name = "Credit Card"
        category2.color = "category_color_2"

        let category3 = Category(context: context)
        category3.assetName = "dinner"
        category3.name = "Dinner"
        category3.color = "category_color_3"

        let category4 = Category(context: context)
        category4.assetName = "credit_card"
        category4.name = "Salary"
        category4.color = "category_color_1"

        let income1 = CashflowItem(context: context)
        income1.amount = 1200
        income1.name = "Salary"
        income1.category = category4
        income1.type = .income
        income1.date = date1

        let expense1 = CashflowItem(context: context)
        expense1.amount = 900
        expense1.name = "Rent"
        expense1.category = category2
        expense1.type = .expense
        expense1.date = date2

        let expense2 = CashflowItem(context: context)
        expense2.amount = 200
        expense2.name = "Food"
        expense2.category = category3
        expense2.type = .expense
        expense2.date = date3

        let expense3 = CashflowItem(context: context)
        expense3.amount = 17.5
        expense3.name = "Sushi"
        expense3.category = category3
        expense3.type = .expense
        expense3.date = date4

        do {
            let cashflow = try CashflowCoreDataRepository(context: context).fetchFor(month: Date().month)
            cashflowViewModel = CashflowViewModel(cashflow)
        } catch {
            fatalError()
        }

    }

    // MARK: - Navigation
    private func presentPeriodPickerView() {
        print("Present period selection view")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cashflowViewModel.movements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movementCellId, for: indexPath)

        if let cell = cell as? MovementTableViewCell {
            let movement = cashflowViewModel.movements[indexPath.row]
            cell.configure(movement: CashflowItemViewModel(movement))
        }

        return cell
    }
}
