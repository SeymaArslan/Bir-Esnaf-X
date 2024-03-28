//
//  SellTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
// delete commitle sonra test et daha sonra kar zarar label mysql tablo falan bak

import UIKit
import FirebaseAuth

class SalesTableViewController: UITableViewController {
    
    var firstProductData = [Product]()
    
    var prodList = [Product]()
    let prodVM = ProductVM()
    
    var saleList = [Sale]()
    let saleVM = SaleVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLeftBarButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 166.0
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSaleList()
    }
    
    @IBAction func addSaleButton(_ sender: Any) {
        // burada tıklama ile veri transferi yapacağız.
        
        // goToAddSale
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRow = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, bool in
            self.showDeleteAlert(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteRow])
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.refreshControl!.isRefreshing {
            self.getSaleList()
            self.refreshControl!.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < saleList.count else {
            return UITableViewCell()
        }
        let sale = saleList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SalesTableViewCell
        cell.prodName.text = sale.prodName
        cell.total.text = sale.saleTotal
        if let price = sale.salePrice {
            cell.salePrice.text = price + " ₺"
        }
        if let tPrice = sale.saleTotalPrice {
            cell.totalPrice.text = tPrice + " ₺"
        }
        cell.saleDate.text = sale.saleDate
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "cellToUpdate", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToUpdate" {
            guard let index = sender as? Int else { return }
            let goToVC = segue.destination as! UpdateSalesViewController
            print("\(saleList[index])")
            goToVC.sale = saleList[index]
        }
        
    }
    
    
    //MARK: - Helpers
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureLeftBarButton() {
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(self.backButtonPressed))]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "customColor2")
    }
    
    func showDeleteAlert(for indexPath: IndexPath) {
        let alertCont = UIAlertController(title: "Seçtiğiniz satırı silmek üzeresiniz", message: "Silme işlemine devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertCont.addAction(cancelAct)
        let continueAct = UIAlertAction(title: "Tamam", style: .destructive) { action in
            DispatchQueue.main.async {
                self.deleteRow(at: indexPath)
            }
        }
        alertCont.addAction(continueAct)
        self.present(alertCont, animated: true)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        let sale = self.saleList[indexPath.row]
        if let saleId = sale.saleId {
            if let intSId = Int(saleId) {
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    self.saleVM.deleteSale(userMail: uid, saleId: intSId)
                    self.saleList.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        if let prodName = sale.prodName, let saleTotal = sale.saleTotal {
            if let doubleSaleTotal = Double(saleTotal) {
                prodVM.fetchProdData(prodName: prodName) { prodData in
                    self.prodList = prodData
                    if let prodTotal = self.prodList.first?.prodTotal {
                        if let doubleProdTotal = Double(prodTotal) {
                            let updateTotal = doubleProdTotal + doubleSaleTotal
                            if let currentUser = Auth.auth().currentUser {
                                let uid = currentUser.uid
                                self.prodVM.productUpdateWithSales(userMail: uid, prodName: prodName, prodTotal: updateTotal)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    
    func getSaleList() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            saleVM.getSaleList(mail: uid) { saleListData in
                self.saleList = saleListData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
