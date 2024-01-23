//
//  ProductTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit

class ProductTableViewController: UITableViewController {

    let mail = userDefaults.string(forKey: "userMail")
    var prodList = [Product]()
    let prodVM = ProductVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 108.0
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getProdList()
    }
    
    
    
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prod = prodList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdCell", for: indexPath) as! ProductTableViewCell
        cell.productName.text = prod.prodName
        cell.totalNumber.text = prod.prodTotal
        cell.priceNumber.text = prod.prodPrice
        return cell
    }
    
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToUpdateProd", sender: indexPath.row) 
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.refreshControl!.isRefreshing {
            self.getProdList()
            self.refreshControl!.endRefreshing()
        }
    }
    
    
    //MARK: - Helpers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCompDet" {
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
