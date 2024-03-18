//
//  TradesmanViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 12.02.2024.
//

import UIKit
import ProgressHUD

class TradeViewController: UIViewController {
    
    //MARK: - Vars for enable/disable buttons
    var shopCount: Int?
    var countShop: String?
    var shopList = [Shop]()
    var saleCount: Int?
    
    var countBuy: String?
    var buyList = [Buy]()
    let buyVM = BuyVM()
    
    var countSale: String?
    var saleList = [Sale]()
    let saleVM = SaleVM()
    
    var countProd: String?
    var prodList = [Product]()
    let prodVM = ProductVM()
    
    var countComp: String?
    var compList = [CompanyBank]()
    let compVM = CompanyVM()
    
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

        getCompanyCount()
        getProdCount()
        getSaleCount()
        //getShopCount()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFirstSale()
        getShopCount()
    }
    
    @IBAction func salesResultButtonPressed(_ sender: Any) {

    }
    
    //MARK: - Helpers
    func getShopCount() {    // clear List button pressed
        self.shopVM.countShop(userMail: mail!) { shopData in
            self.shopList = shopData
            if let count = self.shopList.first?.count {
                self.countShop = count
                if let intShopCount = Int(self.countShop!) {
                    self.shopCount = intShopCount
                    if intShopCount < 1 {
                        DispatchQueue.main.async {
                            self.salesResultButton.isEnabled = false
                            ProgressHUD.showError("'Satış Sonuçlarını Gör' özelliğinin aktif olması için Satış İşlemi girmeniz gerekmektedir.")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.salesResultButton.isEnabled = true
                        }
                    }
                }
                
            }
        }
    }
    
    func getSaleCount() {
        self.saleVM.countSale(userMail: mail!) { saleData in
            self.saleList = saleData
            if let count = self.saleList.first?.count {
                self.countSale = count
                if let intSale = Int(self.countSale!) {
                    self.saleCount = intSale
                    if intSale < 1 {
                        DispatchQueue.main.async {
                            self.salesResultButton.isEnabled = false
                            ProgressHUD.showError("'Satış Sonuçlarını Gör' özelliğinin aktif olması için Satış İşlemi girmeniz gerekmektedir Test.")   // düzelt
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.salesResultButton.isEnabled = true
                        }
                    }
                }
            }
        }
    }
    
    func getProdCount() {
        self.prodVM.countProduct(userMail: mail!) { prodData in
            self.prodList = prodData
            if let count = self.prodList.first?.count {
                self.countProd = count
                if let intProd = Int(self.countProd!) {
                    if intProd < 1 {
                        DispatchQueue.main.async {
                            self.saleButton.isEnabled = false
                            ProgressHUD.showError("'Satış İşlemleri' özelliğinin aktif olması için Ürün ekleyin.")
                        }
                    }
                    
                }
            }
        }
    }
    
    func getCompanyCount() {
        self.compVM.countCompBank(userMail: self.mail!) { compCount in
            self.compList = compCount
            if let count = self.compList.first?.count {
                self.countComp = count
                if let intcomp = Int(self.countComp!) {
                    if intcomp < 1 {
                        DispatchQueue.main.async {
                            self.buyButton.isEnabled = false
                            ProgressHUD.showError("'Alım İşlemleri' özelliğin aktif olması için Firma ekleyin.")
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShop" {
            let goToVC = segue.destination as! ShoppingViewController
            goToVC.firstShopList = firstShopList.first
        }
    }
    
    func getFirstSale() {
        shopVM.getFirstSaleData(userMail: mail!) { firstShopData in
            self.firstShopList = firstShopData
        }
    }
    
}
