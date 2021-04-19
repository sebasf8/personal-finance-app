//
//  AddStatementViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 07/04/2021.
//

import UIKit
import CoreData

class AddStatementItemViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ammountTextField: UITextField!
    @IBOutlet weak var categoryPickerButton: UIButton!
    
    //MARK: - Properties
    let assetCategories = ["Savings", "Investment Portfolio", "Crypto"]
    var container: NSPersistentContainer?
    var selectedCategory: String?
    var statementItem: StatementItem?
    
    let popupWidth = UIScreen.main.bounds.width - 10
    let popupHeigth = UIScreen.main.bounds.height/4
    var categorySelectedRow = 0

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    //MARK: - Setups
    
    private func setupTextFields() {
        nameTextField.tag = 0
        ammountTextField.tag = 1
        
        nameTextField.delegate = self
        ammountTextField.delegate = self
        
        initializeHideKeyboard()
    }
    
    //MARK: - Actions
    @IBAction func popupCategoryPicker(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: popupWidth, height: popupHeigth)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: popupWidth, height: popupHeigth))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(categorySelectedRow, inComponent: 0, animated: true)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Category", message: nil, preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = categoryPickerButton
        alert.popoverPresentationController?.sourceRect = categoryPickerButton.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: {_ in
            self.categorySelectedRow = pickerView.selectedRow(inComponent: 0)
            self.selectedCategory = self.assetCategories[self.categorySelectedRow]
            self.categoryPickerButton.setTitle(self.selectedCategory, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveStatement(_ sender: Any){
        statementItem = StatementItem(context: container!.viewContext)
        let ammount = Double(ammountTextField.text ?? "0.00")!
        
        statementItem!.name = nameTextField.text
        statementItem!.type = .asset
        statementItem!.category = selectedCategory
        statementItem!.ammount = ammount
                
        performSegue(withIdentifier: "toNetworthView", sender: self)
    }
    
    

}

// MARK: - Component delegates

extension AddStatementItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return assetCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return assetCategories[row]
    }
    
}

extension AddStatementItemViewController: UITextFieldDelegate {
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
     if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
         nextField.becomeFirstResponder()
        
     } else {
         textField.resignFirstResponder()
     }
         return false
     }
 }
