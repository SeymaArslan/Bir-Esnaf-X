//
//  ProductTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class ProductTableViewController: UITableViewController {
    
    var saleC = Int()
    var prodDelete = String()
    
    var shopListCount = [Shop]()
    let shopVM = ShopVM()
    var saleListCount = [Sale]()
    let saleVM = SaleVM()
    
    var prodListCount = [Product]()
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
        
        getProdList()
        getProdCount()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < prodList.count else {
            return UITableViewCell()
        }
        
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
    func outOfStock(at id: String, name: String) {
        let alertCont = UIAlertController(title: "Satılan \(name) ürününün stoğu tükendi. Ürünler listenizden silinsin mi?", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertCont.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Tamam", style: .destructive) { action in
            if let intPId = Int(id) {
                print("Silinecek ürün id si = \(intPId)")
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    self.prodVM.deleteProd(userMail: uid, prodId: intPId)
                    ProgressHUD.showSuccess("\(name) listenizden başarılı bir şekilde silindi.")
                }
            }
        }
        alertCont.addAction(okAct)
        self.present(alertCont, animated: true)
    }
    
    
    func totalControl() {
        for prod in self.prodList {
            if let totalOver = prod.prodTotal, let intTotalOver = Int(totalOver), intTotalOver == 0 {
                if let id = prod.prodId, let name = prod.prodName {
                    print("Ürün adı = \(name), id = \(id)")
                    self.outOfStock(at: id, name: name)
                }
            }
        }
    }
    
    
    func showDeleteWarning(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Ürünü Silmek Üzeresiniz", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Tamam", style: .destructive) { action in
            self.deleteProduct(at: indexPath)
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }
    
    
    func deleteProduct(at indexPath: IndexPath) {
        let prod = self.prodList[indexPath.row]
        if let prodId = prod.prodId {
            if let intPId = Int(prodId) {
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    self.prodVM.deleteProd(userMail: uid, prodId: intPId)
                }
                self.prodList.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            prodVM.getAllProd(userMail: uid) { prodData in
                self.prodList = prodData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.totalControl()
                }
                
            }
        }
    }
    
    
    func getProdCount() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            self.prodVM.countProduct(userMail: uid) { prodCount in
                self.prodListCount = prodCount
                if let count = self.prodListCount.first?.count {
                    if let intProd = Int(count) {
                        if intProd == 0 {
                            ProgressHUD.showSuccess("+ ile Ürün ekleyerek uygulamayı kullanmaya başlayın.")
                        }
                    }
                }
            }
        }
    }
}
