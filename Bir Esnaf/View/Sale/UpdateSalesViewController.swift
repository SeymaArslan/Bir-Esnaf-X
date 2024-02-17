//
//  UpdateSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class UpdateSalesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var selectProdComponent = String()
    var forSelectProdPickerList = [Product]()
    let prodVM = ProductVM()
    
    var prodSelect = String()
    var prodList = [Product]()
    
    var saleId = Int()
    let saleVM = SaleVM()
    var sale: Sale?
    
    @IBOutlet weak var prodNamePicker: UIPickerView!
    @IBOutlet weak var salePrice: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var saleDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prodNamePicker.delegate = self
        prodNamePicker.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSaleInformation()
        getCompList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let prodId = forSelectProdPickerList.first?.prodId {
            DispatchQueue.main.async {
                self.selectProdComponent = prodId
                if let intPId = Int(self.selectProdComponent) {
                    let intLastPId = intPId - 1
                    if let prodStr = self.prodList[intLastPId].prodName {
                        self.prodSelect = prodStr
                    }
                    self.prodNamePicker.selectRow(intLastPId, inComponent: 0, animated: true)
                    
                }
                
            }
        }
        
    }
    
    @IBAction func salesUpdateButton(_ sender: Any) {
        update()
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
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
        if let select = prodList[row].prodName {
            prodSelect = select
        }
    }
    
    
    //MARK: - Helpers
    func update() {
        if let salePrice = salePrice.text, let total = total.text, let totalPrice = totalPrice.text, let buyDate = saleDateTextField.text {
            if let doubleSPrice = Double(salePrice), let doubleTotal = Double(total), let doubleTPrice = Double(totalPrice) {
                saleVM.updateSale(saleId: saleId, prodName: prodSelect, salePrice: doubleSPrice, saleTotal: doubleTotal, saleTotalPrice: doubleTPrice, saleDate: buyDate)
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
    
    func getCompList() {
        saleVM.fetchProdList { prodData in
            self.prodList = prodData
            DispatchQueue.main.async {
                self.prodNamePicker.reloadAllComponents()
            }
        }
    }
    
    func getSaleInformation() {
        if let s = sale {
            if let id = s.saleId {
                if let intId = Int(id) {
                    saleId = intId
                }
            }
            
            salePrice.text = s.salePrice
            total.text = s.saleTotal
            totalPrice.text = s.saleTotalPrice
            saleDateTextField.text = s.saleDate
            
            if let getSelectProd = s.prodName {
                prodVM.getSelectedProdPicker(prodName: getSelectProd) { prodData in
                    self.forSelectProdPickerList = prodData
                }
            }
            
        }
    }
    
}


extension UpdateSalesViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        
        salePrice.inputAccessoryView = bar
        total.inputAccessoryView = bar
        totalPrice.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return true
//    }   test it
}
