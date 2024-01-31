//
//  SellTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class SalesTableViewController: UITableViewController {

    let mail = userDefaults.string(forKey: "userMail")
    var saleList = [Sale]()
    let saleVM = SaleVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 208.0
    
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSaleList()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRow = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, bool in
            
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
        let sale = saleList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SalesTableViewCell
        cell.prodName.text = sale.prodName
        cell.total.text = sale.total
        cell.salePrice.text = sale.salePrice
        cell.totalPrice.text = sale.totalPrice
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
    func deleteRow(at indexPath: IndexPath) {
        
    }
    
    func getSaleList() {
        saleVM.getSaleList(mail: mail!) { saleListData in
            self.saleList = saleListData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

}
