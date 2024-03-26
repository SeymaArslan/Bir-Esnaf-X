//
//  UpdateSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit
import FirebaseAuth

class UpdateSalesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var getOldTotal = Double()
    var oldProduct = String()
    var oldTotal = Double()
    
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
        getProdList()
        
    }
    
    @IBAction func salesUpdateButton(_ sender: Any) {
        updateSales()
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
    func updateOldProd() {
        let total = oldTotal + getOldTotal
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            saleVM.oldSaleUpdate(userMail: uid, prodName: oldProduct, prodTotal: total)
        }
    }
    
    func updateSales() {
        var priceRep = salePrice.text
        priceRep = priceRep?.replacingOccurrences(of: ",", with: ".")
        var totalRep = total.text
        totalRep = totalRep?.replacingOccurrences(of: ",", with: ".")
        var totalPriceRep = totalPrice.text
        totalPriceRep = totalPriceRep?.replacingOccurrences(of: ",", with: ".")
        
        if let salePrice = priceRep, let total = totalRep, let totalPrice = totalPriceRep, let buyDate = saleDateTextField.text {
            if let doubleSPrice = Double(salePrice), let doubleTotal = Double(total), let doubleTPrice = Double(totalPrice) {
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    saleVM.updateSale(userMail: uid, saleId: saleId, prodName: prodSelect, salePrice: doubleSPrice, saleTotal: doubleTotal, saleTotalPrice: doubleTPrice, saleDate: buyDate)
                    
                    updateOldProd()
                    self.view.window?.rootViewController?.dismiss(animated: true)
                }

            }
        }
    }
    
    
    func updatePickerStatus(enabled: Bool) { // TEST                            TEST                           TEST                         TEST
        prodNamePicker.isUserInteractionEnabled = enabled
        prodNamePicker.alpha = enabled ? 1.0 : 0.5
    }
    
    
    func getProdList() {
        saleVM.fetchProdList { prodData in
            self.prodList = prodData
            if let getTotal = self.prodList.first?.prodTotal {
                if let doubleGetTotal = Double(getTotal) {
                    self.getOldTotal = doubleGetTotal
                }
            }
            DispatchQueue.main.async {
                self.prodNamePicker.reloadAllComponents()
                if let selectedIndex = self.prodList.firstIndex(where: { $0.prodName == self.prodSelect }) {
                    self.prodNamePicker.selectRow(selectedIndex, inComponent: 0, animated: false)
                }
                let prodNameExists = self.prodList.contains(where: {$0.prodName == self.prodSelect} ) // TEST                            TEST                           TEST                         TEST
                self.updatePickerStatus(enabled: prodNameExists)
            }
        }
    }
    
    func getSaleInformation() {
        if let s = sale {
            if let id = s.saleId, let oldProd = s.prodName, let oldTot = s.saleTotal {
                if let intId = Int(id) {
                    saleId = intId
                }
                oldProduct = oldProd
                if let doubleOldTot = Double(oldTot) {
                    oldTotal = doubleOldTot
                }
            }
            
            salePrice.text = s.salePrice
            total.text = s.saleTotal
            totalPrice.text = s.saleTotalPrice
            saleDateTextField.text = s.saleDate
            
            
            if let getSelectProd = s.prodName {
                prodSelect = getSelectProd // Varsayılan olarak seçili ürünü belirle
                prodVM.getSelectedProdPicker(prodName: getSelectProd) { prodData in
                    self.forSelectProdPickerList = prodData
                    if let selected = self.forSelectProdPickerList.first?.prodName {
                        self.selectProdComponent = selected // seçilmiş ve güncellenmek istenen veriyi aldım
                        DispatchQueue.main.async {
                            self.prodNamePicker.reloadAllComponents() // Veri kaynağını güncelle
                        }
                    }
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
}
