//
//  AddBuyViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class AddBuyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let buyVM = BuyVM()
    var compSelect = String()
    var compList = [CompanyBank]()
    var date = String()
    
    @IBOutlet weak var compPicker: UIPickerView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var buyDate: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        price.addTarget(self, action: #selector(calculate), for: .editingChanged)
        total.addTarget(self, action: #selector(calculate), for: .editingChanged)
        
        compPicker.delegate = self
        compPicker.dataSource = self
        
        productName.delegate = self
        
        createDatePicker()
        
        setupToolBar()
        setupBackgroundTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchComp()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !compList.isEmpty {
            if let selectPicker = compList[0].compName {
                compSelect = selectPicker
            }
        }
    }
    
    @IBAction func saveBuy(_ sender: Any) {
        addBuy()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return compList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return compList[row].compName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerSelect = compList[row].compName {
            compSelect = pickerSelect
            print(compSelect)
        }
    }
    
    //MARK: - Helpers
    @objc func calculate() {
        guard let price = Double(price.text ?? "Olmadı"), let total = Double(total.text ?? "Olmadı") else {
            totalPrice.text = "0"
            return
        }
        let result = price * total
        totalPrice.text = "\(result)"
    }
    
    func fetchComp() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            buyVM.fetchCompList(userMail: uid) { compList in
                self.compList = compList
                DispatchQueue.main.async {
                    self.compPicker.reloadAllComponents()
                }
            }
        }
    }
    
    func addBuy(){
        var priceRep = price.text
        priceRep = priceRep?.replacingOccurrences(of: ",", with: ".")
        var totalRep = total.text
        totalRep = totalRep?.replacingOccurrences(of: ",", with: ".")
        var totalPriceRep = totalPrice.text
        totalPriceRep = totalPriceRep?.replacingOccurrences(of: ",", with: ".")
        
        if let prodName = productName.text, let price = priceRep, let total = totalRep, let tPrice = totalPriceRep, let date = buyDate.text {
            if let dPrice = Double(price), let dTotal = Double(total), let dTP = Double(tPrice) {
                
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    buyVM.addBuy(mail: uid, compName: compSelect, productName: prodName, price: dPrice, total: dTotal, totalPrice: dTP, buyDate: date)
                    
                    ProgressHUD.showSuccess("Alış işlemi kaydedildi.")
                    if let mainVC = presentingViewController as? BuyTableViewController {
                        DispatchQueue.main.async {
                            mainVC.tableView.reloadData()
                        }
                    }
                    self.view.window?.rootViewController?.dismiss(animated: true)
                }
            }
        }
    }
    
    @objc func doneButtonClicked() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeStyle = .none
        buyDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Ekle", style: .plain, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        
        buyDate.inputAccessoryView = toolbar
        buyDate.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
}


extension AddBuyViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        
        price.inputAccessoryView = bar
        total.inputAccessoryView = bar
        totalPrice.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        productName.endEditing(true)
        return true
    }
    
}
