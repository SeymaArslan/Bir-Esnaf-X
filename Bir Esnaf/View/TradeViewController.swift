//
//  TradesmanViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 12.02.2024.
//

import UIKit

class TradeViewController: UIViewController {

    var firstProfitAmount: String?
    var fetchShopList = [Shop]()
    var firstProdName: String?
    var firstShopList = [Shop]()
    let mail = userDefaults.string(forKey: "userMail")
    let shopVM = ShopVM()
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var salesResultButton: UIButton!
    @IBOutlet weak var saleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getFirstSale()
    }
    

    @IBAction func saleResultButtonPressed(_ sender: Any) {
        
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
