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
        
        getCompanyCount()
        getProdCount()
        getSaleCount()
        getFirstSale()
    }

    
    //MARK: - Helpers
    func getSaleCount() {
        self.saleVM.countSale(userMail: mail!) { saleData in
            self.saleList = saleData
            if let count = self.saleList.first?.count {
                self.countSale = count
                if let intSale = Int(self.countSale!) {
                    if intSale < 1 {
                        DispatchQueue.main.async {
                            self.salesResultButton.isEnabled = false
                            ProgressHUD.showError("Bu özelliğin aktif olması için Satış İşlemi girmeniz gerekmektedir.")
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
                            ProgressHUD.showError("Bu özelliğin aktif olması için Ürün ekleyin.")
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
            goToVC.firstShopList = firstShopList.first
        }
    }
    
    func getFirstSale() {
        shopVM.getFirstSaleData(userMail: mail!) { firstShopData in
            self.firstShopList = firstShopData
        }
    }
    
}
