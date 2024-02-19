//
//  UpdateSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class UpdateSalesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var getOldTotal = Double()
    var oldProduct = String()
    var oldTotal = Double()
    
    let mail = userDefaults.string(forKey: "userMail")
    
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
        
        
        // burayı bi elden geçir id ye göre değil count' a göre olmalı çünkü ürün silinebilir ki bu alım alanında da olabilir artı alışverişte de
        
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
        
        self.prodNamePicker.selectRow(1, inComponent: 0, animated: true)  // buradaki 1 -> 0 1. satırı getiriyor istediğim ise index'e göre değil toplam eleman sayısına göre çekmekse ki adını aldım diyelim Tabak id si 6 tablodaki toplam eleman sayısı ise 2 ise aslında yapmam gereken eleman sayısını almak ardından
        
        
        
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
        saleVM.oldSaleUpdate(userMail: mail!, prodName: oldProduct, prodTotal: total)
        print("oldProd = \(oldProduct) ve prodTotal = \(oldTotal)")
        print("Oldu muuuuu buradaki total geri eklenmiş olmalı..")
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
                saleVM.updateSale(userMail: mail!, saleId: saleId, prodName: prodSelect, salePrice: doubleSPrice, saleTotal: doubleTotal, saleTotalPrice: doubleTPrice, saleDate: buyDate)
                
                updateOldProd()
                
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
    
    func getCompList() {
        saleVM.fetchProdList { prodData in
            self.prodList = prodData
            if let getTotal = self.prodList.first?.prodTotal {
                if let doubleGetTotal = Double(getTotal) {
                    self.getOldTotal = doubleGetTotal
                    print("Geliyor mu o an ki total miktarı? = \(self.getOldTotal)")  // geldi
                }
            }
            DispatchQueue.main.async {
                self.prodNamePicker.reloadAllComponents()
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
                prodVM.getSelectedProdPicker(prodName: getSelectProd) { prodData in
                    self.forSelectProdPickerList = prodData
//                    if let row = forSelectProdPickerList.first(where: { $0 == oldProduct }) {
//                        prodNamePicker.selectRow(row, inComponent: 0, animated: true)
//                    }
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
