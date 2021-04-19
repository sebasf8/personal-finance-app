//
//  ElementDetailViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 04/04/2021.
//

import UIKit
import CoreData

class StatementItemViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    //MARK: - Properties
    
    var statementItem: StatementItem?
    var history: [StatementItemMeasure]?
    var container: NSPersistentContainer?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupStatementItemDetail()
        setupStatementItemHistoryTable()
    }
    
    //MARK: - Setup
    
    private func setupStatementItemDetail() {
        nameLabel.text = statementItem!.name
        ammountLabel.text = NumberFormatters.currencyFormatter.string(from: statementItem!.ammount as NSNumber)
        categoryLabel.text = statementItem!.category
    }
    
    private func setupStatementItemHistoryTable() {
        history = statementItem!.history?.allObjects as? [StatementItemMeasure]
        history?.sort(by: {$0.date! > $1.date!})
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")
    }
    
    // MARK: - Actions
    
    @IBAction func popupAddHistoryItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add measurement", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields![0].keyboardType = .decimalPad
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {_ in
            let ammountText = alert.textFields![0].text!
            
            if ammountText != "" {
                self.saveHistoryItem(ammount:Double(ammountText)!)
            }
            
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToNetworth(_ sender: Any) {
        performSegue(withIdentifier: "unwindToNetworth", sender: self)
    }
    
    
    // MARK: - Internal functions
    
    private func saveHistoryItem(ammount: Double) {
        let stm = StatementItemMeasure(context: self.container!.viewContext)
        stm.ammount = ammount
        stm.date = Date()
        
        self.statementItem?.addToHistory(stm)
        self.statementItem?.ammount = ammount
        
        try! self.container!.viewContext.save()
        self.history?.insert(stm, at: 0)
        
        self.historyTableView.insertRows(at: [IndexPath(row:0, section: 0)], with: .automatic)
        self.ammountLabel.text = NumberFormatters.currencyFormatter.string(for: ammount as NSNumber)
    }
}

// MARK: - History Table extension

extension StatementItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statementItem?.history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        let historyItem = history![indexPath.row]
        
        cell.ammountLabel.text = NumberFormatters.currencyFormatter.string(for: historyItem.ammount)
        cell.dateLabel.text = DateFormatter.localizedString(from: historyItem.date!, dateStyle: .short, timeStyle: .short)
        return cell
    }
}

