//
//  TradesmanViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 12.02.2024.
//

import UIKit
import ProgressHUD

class TradeViewController: UIViewController {
    
    var countProd: String?
    var prodList = [Product]()
    let prodVM = ProductVM()

    var countComp: String?
    var compList = [CompanyBank]()
    let compVM = CompanyVM()
    // burada firma ve ürün tablolarına göre visible durumu olacak eğer firma (companyBank) eklenmediyse alım tablosu visible, eğer ürün (product) eklenmediyse satış tablosu visible
    // artı satış tablosu boşsa saleResult visible

    // these vars and constants are for in shopVC
    var firstProfitAmount: String?
    var fetchShopList = [Shop]()
    var firstProdName: String?
    var firstShopList = [Shop]()
    let mail = userDefaults.string(forKey: "userMail")
    let shopVM = ShopVM()
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var salesResultButton: UIButton!
    @IBOutlet weak var saleButton: UIButton!
    
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFirstSale()
        
        
        getCompany()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @IBAction func buyButtonPressed(_ sender: Any) {  // bağlantıyı ve burayuı sil
        if self.buyButton.isEnabled == false {
            ProgressHUD.show("Bu özelliğin aktif olması için Firma ekleyin.")
        }
    }
    
    @IBAction func saleResultButtonPressed(_ sender: Any) {
    }
    
    
    //MARK: - Helpers
    func getProd() {
        self.prodVM.countProduct(userMail: mail!) { prodData in
            self.prodList = prodData
            if let count = self.prodList.first?.count {
                self.countProd = count
                if let intProd = Int(self.countProd!) {
                    if intProd < 1 {
                        DispatchQueue.main.async {
                            self.saleButton.isEnabled = false
                            ProgressHUD.showError("Bu özelliğin aktif olması için Ürün ekleyin.")
                        }
                    }
                }
            }
        }
    }
    
    func getCompany() {
            self.compVM.countCompBank(userMail: self.mail!) { compCount in
                self.compList = compCount
                if let count = self.compList.first?.count {
                    self.countComp = count
                    if let intcomp = Int(self.countComp!) {
                        if intcomp < 1 {
                            DispatchQueue.main.async {
                                self.buyButton.isEnabled = false
                                ProgressHUD.showError("Bu özelliğin aktif olması için Firma ekleyin.")
                            }
                        }
                    }
                }
            }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShop" {
            let goToVC = segue.destination as! ShoppingViewController
            if let pName = firstProdName, let amount = firstProfitAmount {
                goToVC.firstProdName = pName
                goToVC.firstProfitAmount = amount
            }
        }
    }
    
    
    func getFirstSale() {
        shopVM.getFirstSaleData(userMail: mail!) { firstShopData in
            self.firstShopList = firstShopData
            if let pname = firstShopData.first?.prodName {
                self.firstProdName = pname
                
                self.shopVM.fetchShop(userMail: self.mail!, prodName: self.firstProdName!) { shopData in
                    self.fetchShopList = shopData
                    if let str = self.fetchShopList.first?.totalProfitAmount {
                        if let intStr = Int(str) {
                            if intStr > 0 {
                                DispatchQueue.main.async {
                                    self.firstProfitAmount = str + " ₺"
                                    if let profAmo = self.firstProfitAmount {
                                        print("profit amount = \(profAmo)")
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
}
