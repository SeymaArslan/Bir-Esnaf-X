//
//  AddSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class AddSalesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var prodId = String()
    let productVM = ProductVM()
    let shopVM = ShopVM()
    var prodPrice = String()  // maaliyet
    var prodTotal = String()  // elimizdeki toplam ürün sayısı
    
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
        
        salePrice.addTarget(self, action: #selector(calculate), for: .editingChanged)
        total.addTarget(self, action: #selector(calculate), for: .editingChanged)
        
        prodPicker.delegate = self
        prodPicker.dataSource = self
        
        createDatePicker()
        
        setupToolBar()
        setupBackgroundTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProd()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !prodList.isEmpty {
            if let selectPicker = prodList[0].prodName, let pickerPrice = prodList[0].prodPrice, let pickerTotal = prodList[0].prodTotal {
                prodSelect = selectPicker
                prodPrice = pickerPrice
                prodTotal = pickerTotal
            }
        }
    }
    
    
    //MARK: - IB Actions
    @IBAction func saveSaleButton(_ sender: Any) {
        addSale()
        if let mainVC = presentingViewController as? SalesTableViewController {
            DispatchQueue.main.async {
                mainVC.tableView.reloadData()
            }
        }
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
        if let pickerSelect = prodList[row].prodName, let pickerPrice = prodList[row].prodPrice, let pickerTotal = prodList[row].prodTotal, let pId = prodList[row].prodId {
            prodSelect = pickerSelect
            prodPrice = pickerPrice
            prodTotal = pickerTotal
            prodId = pId
        }
    }
    
    
    //MARK: - Helpers
    @objc func calculate() {
        guard let price = Double(salePrice.text ?? "Yok"), let total = Double(total.text ?? "Yok") else {
            totalPrice.text = "0"
            return
        }
        let result = price * total
        totalPrice.text = "\(result)"
    }
    
    func countProfitAmount(prodSelect: String, prodPrice: Double, prodTotal: Double, salePrice: Double, saleTotal: Double) {
        let priceDifference = salePrice - prodPrice // kar için
        let totalRemainingProduct = prodTotal - saleTotal // Product güncelleme için prodTotal toplam ürün miktarı saleTotal satılan
        
        let amount = priceDifference * saleTotal  // satış kar
        
        if totalRemainingProduct > 0 {
            
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                shopVM.addShop(userMail: uid, prodName: prodSelect, totalProfitAmount: amount)
                productVM.productUpdateWithSales(userMail: uid, prodName: prodSelect, prodTotal: totalRemainingProduct)
                
                
            }

        }
        
        if totalRemainingProduct == 0 {
           ProgressHUD.showSuccess("Satılan \(prodSelect) ürününün stoğu tükendi.")
           let alertCont = UIAlertController(title: "Satılan \(prodSelect) ürününün stoğu tükendi. Ürünler listenizden silinsin mi?", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
           let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
           alertCont.addAction(cancelAct)
           let okAct = UIAlertAction(title: "Tamam", style: .destructive) { [self] action in
               if let intPId = Int(prodId) {
                   if let currentUser = Auth.auth().currentUser {
                       let uid = currentUser.uid
                       self.productVM.deleteProd(userMail: uid, prodId: intPId)
                       ProgressHUD.showSuccess("\(prodSelect) listenizden başarılı bir şekilde silindi.")
                       //  TEST ET
                   }
               }
           }
           alertCont.addAction(okAct)
           self.present(alertCont, animated: true)
       }
        
    }
    
    func addSale() {
        var sPriceRep = salePrice.text
        sPriceRep = sPriceRep?.replacingOccurrences(of: ",", with: ".")
        var totalRep = total.text
        totalRep = totalRep?.replacingOccurrences(of: ",", with: ".")
        var totalPriceRep = totalPrice.text
        totalPriceRep = totalPriceRep?.replacingOccurrences(of: ",", with: ".")
        
        if let salePrice = sPriceRep, let saleTotal = totalRep, let totalSalePrice = totalPriceRep, let date = saleDateTextField.text {
            if let doubleSalePrice = Double(salePrice), let doubleSaleTotal = Double(saleTotal), let doubleTotalSalePrice = Double(totalSalePrice), let doubleProdTotal = Double(prodTotal)  {
                if doubleProdTotal >= doubleSaleTotal {
                    if let currentUser = Auth.auth().currentUser {
                        let uid = currentUser.uid
                        saleVM.addSale(mail: uid, prodName: prodSelect, salePrice: doubleSalePrice, saleTotal: doubleSaleTotal, saleTotalPrice: doubleTotalSalePrice, saleDate: date)
                    
                        if let doubleProdPrice = Double(prodPrice) {
                            countProfitAmount(prodSelect: prodSelect, prodPrice: doubleProdPrice, prodTotal: doubleProdTotal, salePrice: doubleSalePrice, saleTotal: doubleSaleTotal)
                        }
                    }
                } else {     // burası ....
                    ProgressHUD.showError("Ürün stoğu satış için yetersiz.")
                    self.view.window?.rootViewController?.dismiss(animated: true)
                }
                
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
        
        let doneButton = UIBarButtonItem(title: "Ekle", style: .plain, target: nil, action: #selector(addButtonClicked))
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


extension AddSalesViewController: UITextFieldDelegate {
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
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
}
