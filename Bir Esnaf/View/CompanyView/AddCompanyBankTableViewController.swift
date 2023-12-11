//
//  AddCompanyBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//  add için comp id alacağız servisi yazarken unutma

import UIKit

class AddCompanyBankTableViewController: UITableViewController {

    var userId: Int?
    var compId: Int?
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBranchName: UITextField!
    @IBOutlet weak var bankBranchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    
    @IBOutlet weak var iban: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveBankButton(_ sender: Any) {
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



    
}
