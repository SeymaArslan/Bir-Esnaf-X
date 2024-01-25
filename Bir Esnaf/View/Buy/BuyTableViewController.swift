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
        cell.priceLabel.text = buy.price
        cell.totalLabel.text = buy.total
        cell.totalPriceLabel.text = buy.totalPrice
        cell.dateLabel.text = buy.buyDate
        return cell
    }
    
    //MARK: - Helpers
    func getBuyList() {
        buyVM.getBuyList(userMail: mail!) { fetchBuyList in
            self.buyList = fetchBuyList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    


}
