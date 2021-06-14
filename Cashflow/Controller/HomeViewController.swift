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

    var cashflowViewModel: CashflowViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

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
