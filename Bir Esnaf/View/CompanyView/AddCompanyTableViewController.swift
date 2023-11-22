//
//  AddCompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit

class AddCompanyTableViewController: UITableViewController {

    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compLogo: UIImageView!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func compLogoEditButton(_ sender: Any) {
        
    }
    
    @IBAction func goToBankButton(_ sender: Any) {
        
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
