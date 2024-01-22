//
//  ProductTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit

class ProductTableViewController: UITableViewController {

    var prodList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prod = prodList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdCell", for: indexPath) as! ProductTableViewCell
        cell.productName.text = prod.prodName
        return cell
    }



}
