//
//  ShoppingViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//  a

import UIKit

class ShoppingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let saleVM = SaleVM()
    
    var firstShopList: Shop?
    var saleComponent = String()
    var sumShopList = [Shop]()
    var fetchShopList = [Shop]()  // getProvList
    
    var shopSelect = String()
    var shopList = [Shop]()  // provinceList
    let mail = userDefaults.string(forKey: "userMail")
    let shopVM = ShopVM()
    
    @IBOutlet weak var salePicker: UIPickerView!
    @IBOutlet weak var profitAmount: UILabel!
    @IBOutlet weak var totalProfitAmount: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalProfitAmount.text = "0 ₺"
        
        salePicker.delegate = self
        salePicker.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFirstShop()
        pullSales()
    }

    @IBAction func clearAllList(_ sender: Any) {
        clearShopAndSaleList()
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        sumAllSell()
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    
    //MARK: - Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shopList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shopList[row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerSelect = shopList[row].prodName {
            shopSelect = pickerSelect
            fetchShop()
        }
    }
    
    
    //MARK: - Helpers
    func clearShopAndSaleList() {
        let alertController = UIAlertController(title: "Satış sonuçları listesini temizlemek üzeresiniz.", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Tamam", style: .destructive) { action in
            DispatchQueue.main.async {
                self.shopVM.clearAllListInShop(userMail: self.mail!)
                self.profitAmount.text = "0 ₺"
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
        
    }
    
    func getFirstShop() {
        if let firstShop = firstShopList {
            if let selectedName = firstShop.prodName, let selectedTotal = firstShop.totalProfitAmount {
                shopSelect = selectedName
                DispatchQueue.main.async {
                    self.salePicker.reloadAllComponents()
                    self.profitAmount.text = selectedTotal + " ₺"
                    if let intSelectedTotal = Int(selectedTotal) {
                        if intSelectedTotal < 0 {
                            self.profitAmount.textColor = .red
                        } else {
                            self.profitAmount.textColor = UIColor(named: "customColor")
                        }
                    }
                }
                
            }
        }
    }
    
    func sumAllSell() {
        shopVM.sumAllSellProd(userMail: mail!) { sumShop in
            self.sumShopList = sumShop
            if let string = self.sumShopList.first?.totalProfitAmount {
                if let doubleStr = Double(string) { 
                    if doubleStr > 0 {
                        DispatchQueue.main.async {
                            self.totalProfitAmount.text = string + " ₺"
                            self.totalProfitAmount.textColor = UIColor(named: "customColor")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.totalProfitAmount.text = string + " ₺"
                            self.totalProfitAmount.textColor = .red
                        }
                    }
                }
            }
        }
    }
    
    func fetchShop() {
        shopVM.fetchShop(userMail: mail!, prodName: shopSelect) { shopData in
            self.fetchShopList = shopData
            if let str = self.fetchShopList.first?.totalProfitAmount {
                if let doubleStr = Double(str) {
                    if doubleStr > 0 {
                        DispatchQueue.main.async {
                            self.profitAmount.text = str + " ₺"
                            self.profitAmount.textColor = UIColor(named: "customColor")
                        }
                    } else if doubleStr < 0 {
                        DispatchQueue.main.async {
                            self.profitAmount.text = str + " ₺"
                            self.profitAmount.textColor = .red
                        }
                    }
                }
            }
        }
    }
    
    func pullSales() {
        shopVM.pullSalesForPickerView(userMail: mail!) { shopList in
            self.shopList = shopList
            DispatchQueue.main.async {
                self.salePicker.reloadAllComponents()
                if let selectedIndex = self.shopList.firstIndex(where: { $0.prodName == self.shopSelect}) {
                    self.salePicker.selectRow(selectedIndex, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    
}
