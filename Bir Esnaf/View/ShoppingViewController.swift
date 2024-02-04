//
//  ShoppingViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//

import UIKit

class ShoppingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    let visible = false // eğer sale tablosu boşsa false doluysa true yapıp UI ları göstereceğiz?
    
    var fetchShopList = [Shop]()
    var shopSelect = String()
    var shopList = [Shop]()
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
        if !shopList.isEmpty {
            if let selectPicker = shopList[0].prodName {
                shopSelect = selectPicker
            }
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        
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
            print(shopSelect)
            fetchShop()
        }
    }
    
    
    //MARK: - Helpers
    func fetchShop() {
        shopVM.fetchShop(userMail: mail!, prodName: shopSelect) { shopData in
            self.fetchShopList = shopData
            if let str = self.fetchShopList.first?.totalProfitAmount {
                DispatchQueue.main.async {
                    self.profitAmount.text = str + " ₺"
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
