//
//  ViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/04/2021.
//

import UIKit
import CoreData

class NetWorthViewController: UIViewController {
    //MARK: -IBOutlets
    
    @IBOutlet weak var totalNetworth: UILabel!
    @IBOutlet weak var assetsTable: UITableView!
    
    //MARK: - Properties
    
    var container: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var networth: Networth!
    let currencyFormatter: NumberFormatter = NumberFormatters.currencyFormatter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Activos"
        
        loadData()
        setupNavigationBar()
        setupAssetsTable()
        
    }
    // MARK: - Setup

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addElement))
    }
    
    private func setupAssetsTable() {
        assetsTable.delegate = self
        assetsTable.dataSource = self
        assetsTable.tableFooterView = UIView()
        assetsTable.rowHeight = CGFloat(80)
        assetsTable.register(UINib(nibName: "StatementTableViewCell", bundle: nil), forCellReuseIdentifier: "statementCell")
    }
    
    private func loadData() {
        networth = Networth(container: self.container)
        totalNetworth.text = currencyFormatter.string(from: NSNumber(value:networth.getResult()))
        
        DispatchQueue.main.async {
            self.assetsTable.reloadData()
        }
    }
    
    //MARK: - IBActions
    @objc func addElement(_ sender: Any) {
        if let addStatementView = storyboard?.instantiateViewController(identifier: "AddStatementView") as? AddStatementItemViewController {
            
            addStatementView.container = self.container
            
            navigationController?.pushViewController(addStatementView, animated: true)
        }
    }
    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? StatementItemViewController, let si = sourceViewController.statementItem {
            
            if let selectedIndexPath = assetsTable.indexPathForSelectedRow {
                networth.assets[selectedIndexPath.row] = si
                assetsTable.reloadRows(at: [selectedIndexPath], with: .none)
                totalNetworth.text = currencyFormatter.string(from: NSNumber(value:networth!.getResult()))
            }
        } else if let sourceViewController = sender.source as? AddStatementItemViewController, let si = sourceViewController.statementItem {
            let newIndexPath = IndexPath(row: networth.assets.count, section: 0)
            
            networth.addAsset(asset: si)
            
            assetsTable.insertRows(at: [newIndexPath], with: .automatic)
            totalNetworth.text = currencyFormatter.string(from: NSNumber(value:networth!.getResult()))
        }
    }
}

//MARK: - UITable Extention

extension NetWorthViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return networth.assets.count
        case 1:
            return networth.liabilities.count
        default:
            fatalError("Section is not implemented at networth table.")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statementCell", for: indexPath) as? StatementTableViewCell
        var statementItem: StatementItem!
        
        switch indexPath.section {
        case 0:
            statementItem = networth.assets[indexPath.row]
        case 1:
            statementItem = networth.liabilities[indexPath.row]
        default:
            fatalError("Section is not implemented at networth table.")
        }
        
        cell?.nameLabel.text = statementItem.name
        cell?.ammountLabel.text = currencyFormatter.string(from: statementItem.ammount as NSNumber)
        cell?.categoryLabel.text = statementItem.category
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let assetDetailView = storyboard?.instantiateViewController(identifier: "AssetDetail") as? StatementItemViewController {
            switch indexPath.section {
            case 0:
                assetDetailView.statementItem = networth.assets[indexPath.row]
            case 1:
                assetDetailView.statementItem = networth.liabilities[indexPath.row]
            default:
                fatalError("Section is not implemented at networth table.")
            }
            
            assetDetailView.container = self.container
            navigationController?.pushViewController(assetDetailView, animated: true)
        }
    }
}


