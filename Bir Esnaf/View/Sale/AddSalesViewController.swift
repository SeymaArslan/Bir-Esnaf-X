//
//  AddSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class AddSalesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var prodPrice = String()  // maaliyet
    var prodTotal = String()  // elimizdeki toplam ürün sayısı
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
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
        if let pickerSelect = prodList[row].prodName, let pickerPrice = prodList[row].prodPrice, let pickerTotal = prodList[row].prodTotal {
            prodSelect = pickerSelect
            prodPrice = pickerPrice
            prodTotal = pickerTotal
            print("prod = \(prodSelect) - Price = \(prodPrice) - total = \(prodTotal) ")
            print(prodSelect)
        }
    }
    
    
    //MARK: - Helpers
    func countProfitAmount(prodPrice: Double, salePrice: Double, prodTotal: Double, total: Double) {
       //  veritabanı oluşturup kaydedeceğiz
        // totalFarkını üründen çıkaracağız
        // price farkını ise total miktarı ile çarpıp karı bulacağız. sonra da karı aynı tabloya ekleyeceğiz.
        // veritabanında userMail ve prodName de olacak shopping sayfasında prodName e göre veri çekeceğiz 
        let priceDiff = salePrice - prodPrice
        let totalDiff = prodTotal - total

    }
    
    func addSale() {
        if let userMail = mail, let sPrice = salePrice.text, let total = total.text, let totPrice = totalPrice.text, let date = saleDateTextField.text {
            if let doublePrice = Double(sPrice), let doubleTotal = Double(total), let doubleTPrice = Double(totPrice) {
                
                saleVM.addSale(mail: userMail, prodName: prodSelect, salePrice: doublePrice, total: doubleTotal, totalPrice: doubleTPrice, saleDate: date)
                
                if let doubleProdPrice = Double(prodPrice), let doubleProdTotal = Double(prodTotal) {
                    countProfitAmount(prodPrice: doubleProdPrice, salePrice: doublePrice, prodTotal: doubleProdTotal, total: doubleTotal)
                }
                
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
            self.prodList = prodData  // tüm datalar geliyor artık şimdi seçilen prod un diğer verilerine ulaşacağız
            DispatchQueue.main.async {
                self.prodPicker.reloadAllComponents()
            }
        }
    }
    
}
