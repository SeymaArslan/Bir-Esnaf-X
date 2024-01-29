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
        
    }

    // MARK: - Table view data source

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
    

}
