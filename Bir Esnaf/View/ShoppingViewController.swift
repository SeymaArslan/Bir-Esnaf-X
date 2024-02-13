//
//  ShoppingViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//  a

import UIKit

class ShoppingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let visible = false // eğer sale tablosu boşsa false doluysa true yapıp UI ları göstereceğiz?
    
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
        
        profitAmount.text = "0 ₺"
        totalProfitAmount.text = "0 ₺"
        
        salePicker.delegate = self
        salePicker.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pullSales()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.shopList.isEmpty {
            if let shopStr = self.shopList[0].prodName {
                self.shopSelect = shopStr
            }
        }
        
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
    func fetchFirstData() {
        if !shopList.isEmpty {
            if let selectPicker = shopList.first?.prodName, let pickerId = shopList[0].shopId {
                
                self.shopSelect = selectPicker
                print(" - - - - - - - -- - -- - -- - - -- - -- \(self.shopSelect)")
                if let intId = Int(pickerId) {
                    self.salePicker.selectRow(intId, inComponent: 0, animated: true)
                }
            }
        }
        
    }
    
    func sumAllSell() {
        shopVM.sumAllSellProd(userMail: mail!) { sumShop in
            self.sumShopList = sumShop
            if let string = self.sumShopList.first?.totalProfitAmount {
                if let intStr = Int(string) {  // test
                    if intStr > 0 {
                        DispatchQueue.main.async {
                            self.totalProfitAmount.text = string + " ₺"
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
                if let intStr = Int(str) {
                    if intStr > 0 {
                        DispatchQueue.main.async {
                            self.profitAmount.text = str + " ₺"
                        }
                    } else {
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
            }
        }
    }
    
    
}
