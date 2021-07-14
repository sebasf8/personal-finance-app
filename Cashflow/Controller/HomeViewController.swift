//
//  HomeViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 30/05/2021.
//

import UIKit
import CoreData
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak private var currentBalanceLabel: UILabel!
    @IBOutlet weak private var periodButton: UIButton!
    @IBOutlet weak private var incomeInPeriodLabel: UILabel!
    @IBOutlet weak private var expenseInPeriodLabel: UILabel!
    @IBOutlet weak private var movementsTable: UITableView!

    private let movementCellId = "movementCell"
    private var movementsCount = 0
    var cashflowViewModel: CashflowViewModel?
    var suscribers: Set<AnyCancellable> = []

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
        guard let viewModel = cashflowViewModel else { return }
        suscribers = [
            viewModel.$currentBalance.assign(to: \.text!, on: currentBalanceLabel),
            viewModel.$incomes.assign(to: \.text!, on: incomeInPeriodLabel),
            viewModel.$expenses.assign(to: \.text!, on: expenseInPeriodLabel)
        ]

        viewModel.$period.sink { [weak self] period in
            self?.periodButton.setTitle(viewModel.period, for: .normal)
        }.store(in: &suscribers)
    }

    private func configureMovementsTable() {
        let cellView = UINib(nibName: "MovementTableViewCell", bundle: nil)
        movementsTable.delegate = self
        movementsTable.dataSource = self
        movementsTable.rowHeight = UITableView.automaticDimension
        movementsTable.estimatedRowHeight = 100
        movementsTable.register(cellView, forCellReuseIdentifier: movementCellId)

        cashflowViewModel?.$movementsCount.sink { [weak self] movementsCount in
            self?.movementsCount = movementsCount
            self?.movementsTable.reloadData()
        }.store(in: &suscribers)
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
       movementsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movementCellId, for: indexPath)

        if let cell = cell as? MovementTableViewCell, let viewModel = cashflowViewModel {
            let movement = viewModel.getMovement(at: indexPath.row)
            cell.configure(movement: movement)
        }

        return cell
    }
}
