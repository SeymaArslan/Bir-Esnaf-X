//
//  BuyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import UIKit

class BuyTableViewController: UITableViewController {

    let mail = userDefaults.string(forKey: "userMail")
    var buyList = [Buy]()
    let buyVM = BuyVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 234.0
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBuyList()
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return buyList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buy = buyList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyCell", for: indexPath) as! BuyTableViewCell
        cell.compName.text = buy.compName
        cell.productName.text = buy.productName
        cell.priceLabel.text = buy.price
        cell.totalLabel.text = buy.total
        cell.totalPriceLabel.text = buy.totalPrice
        cell.dateLabel.text = buy.buyDate
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToBuyUpdate", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.refreshControl!.isRefreshing {
            self.getBuyList()
            self.refreshControl!.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Sil") { contAct, view, bool in
            self.showDeleteAlert(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    //MARK: - Helpers
    func showDeleteAlert(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Seçilen Satırı Silmek Üzeresiniz", message: "Silme işlemine devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAction)
        let continueAct = UIAlertAction(title: "Tamam", style: .destructive) { act in
            DispatchQueue.main.async {
                self.deleteCell(at: indexPath)
            }
        }
        alertController.addAction(continueAct)
        self.present(alertController, animated: true)
    }
    
    func deleteCell(at indexPath: IndexPath) {
        let buy = self.buyList[indexPath.row]
        if let buyId = buy.buyId {
            if let intBuyId = Int(buyId) {
                self.buyVM.deleteCell(buyId: intBuyId)
                self.getBuyList()
            }
        }
    }
    
    func getBuyList() {
        buyVM.getBuyList(userMail: mail!) { fetchBuyList in
            self.buyList = fetchBuyList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBuyUpdate" {
            guard let index = sender as? Int else { return }
            let goToVC = segue.destination as! UpdateBuyViewController
            goToVC.buy = buyList[index]
        }
        
    }

}
