//
//  AddSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class AddSalesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let mail = userDefaults.string(forKey: "userMail")
    let saleVM = SaleVM()
    
    var prodSelect = String()
    var prodList = [Product]()
    var date = String()
    
    
    //MARK: - IB Outlets
    @IBOutlet weak var prodPicker: UIPickerView!
    @IBOutlet weak var salePrice: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var saleDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prodPicker.delegate = self
        prodPicker.dataSource = self
        
        createDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProd()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !prodList.isEmpty {
            if let selectPicker = prodList[0].prodName {
                prodSelect = selectPicker
            }
        }
    }
    
    //MARK: - IB Actions
    @IBAction func saveSaleButton(_ sender: Any) {
        addSale()
    }
    
    
    @IBAction func dismissButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prodList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return prodList[row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerSelect = prodList[row].prodName {
            prodSelect = pickerSelect
            print(prodSelect)
        }
    }
    
    
    //MARK: - Helpers
    func addSale() {
        if let sPrice = salePrice.text, let total = total.text, let totPrice = totalPrice.text, let date = saleDateTextField.text {
            if let doublePrice = Double(sPrice), let doubleTotal = Double(total), let doubleTPrice = Double(totPrice) {
                print(mail!)
                print(prodSelect)
                print(doublePrice)
                print(doubleTotal)
                print(doubleTPrice)
                print(date)
                
                saleVM.addSale(mail: mail!, prodName: prodSelect, salePrice: doublePrice, total: doubleTotal, totalPrice: doubleTPrice, saleDate: date)
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
    
    @objc func addButtonClicked() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeStyle = .none
        saleDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(addButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        saleDateTextField.inputAccessoryView = toolbar
        saleDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    func fetchProd() {
        saleVM.fetchProdList { prodData in
            self.prodList = prodData
            DispatchQueue.main.async {
                self.prodPicker.reloadAllComponents()
            }
        }
    }
    
}
