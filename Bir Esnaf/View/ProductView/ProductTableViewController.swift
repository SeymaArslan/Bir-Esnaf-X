//
//  ProductTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit

class ProductTableViewController: UITableViewController {

    var shopListCount = [Shop]()
    let shopVM = ShopVM()
    var saleListCount = [Sale]()
    let saleVM = SaleVM()
    
    let mail = userDefaults.string(forKey: "userMail")
    var prodList = [Product]()
    let prodVM = ProductVM()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 123.0
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getProdList()
    }
    
    
    
    // MARK: - Table view data source    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prod = prodList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdCell", for: indexPath) as! ProductTableViewCell
        cell.productName.text = prod.prodName
        cell.totalNumber.text = prod.prodTotal
        if let price = prod.prodPrice {
            cell.priceNumber.text = price + " ₺"
        }
        return cell
    }
    
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToUpdateProd", sender: indexPath.row) 
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAct = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAct])
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.refreshControl!.isRefreshing {
            self.getProdList()
            self.refreshControl!.endRefreshing()
        }
    }
    
    
    //MARK: - Helpers
    func showDeleteWarning(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Ürünü Silmek Üzeresiniz", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Tamam", style: .destructive) { action in
            DispatchQueue.main.async {
                self.deleteProduct(at: indexPath)
                self.productSalesControl(at: indexPath)
            }
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }
    
    func showDeleteWarningForShop(for prod: String) {      // TEST ET
        let alertController = UIAlertController(title: "Sildiğiniz ürün 'Satış Sonuçları' listesinde de mevcut. Bu listeden de silmek ister misiniz?", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAction)
        let okeyAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
            self.shopVM.deleteFromShopWhenProductsIsDeleted(userMail: self.mail!, prodName: prod)
        }
        alertController.addAction(okeyAction)
        self.present(alertController, animated: true)
    }
    
    func showDeleteWarningForSale(for prod: String) {      // TEST ET
        let alertController = UIAlertController(title: "Sildiğiniz ürün 'Satış İşlemleri' listesinde de mevcut. Silinen ürünün bütün satış kayıtlarını silmek ister misiniz?", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAction)
        let okeyAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
            self.saleVM.deleteFromSaleWhenProductsIsDeleted(userMail: self.mail!, prodName: prod)
        }
        alertController.addAction(okeyAction)
        self.present(alertController, animated: true)
    }
    
    func productSalesControl(at indexPath: IndexPath) {
        let prod = self.prodList[indexPath.row]
        if let prodName = prod.prodName {
            saleVM.productSaleControl(userMail: mail!, prodName: prodName) { saleCount in
               // self.saleListCount = saleCount
                let saleC = saleCount.count
                print("Sale Count geldi mi? \(saleC)") // geliyor
                if saleC > 0 {
                    self.showDeleteWarningForSale(for: prodName)
                }
            }
            shopVM.productShopControl(userMail: mail!, prodName: prodName) { shopCount in
                self.shopListCount = shopCount
                let shopC = self.shopListCount.count
                print("Shop count geldi mi? \(shopC)") // geliyor
                if shopC > 0 {
                    self.showDeleteWarningForShop(for: prodName)
                }
            }
        }
    }
    
    func deleteProduct(at indexPath: IndexPath) {
        let prod = self.prodList[indexPath.row]
        if let prodId = prod.prodId {
            if let intPId = Int(prodId) {
                self.prodVM.deleteProd(userMail: mail!, prodId: intPId)
                self.getProdList()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUpdateProd" {
            guard let indeks = sender as? Int else { return }
            let goToVC = segue.destination as! UpdateProductViewController
            goToVC.product = prodList[indeks]
        }
    }
    
    func getProdList() {
        prodVM.getAllProd(userMail: mail!) { prodData in
            self.prodList = prodData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
