//
//  CompanyDetailBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit

class CompanyDetailBankTableViewController: UITableViewController {

    var comp: Company?
    
    var bankList = [Bank]()
    let compVM = CompanyVM()
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBranchName: UITextField!
    @IBOutlet weak var bankBranchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var accountName: UITextField!
    
    @IBOutlet weak var iban: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bankName.text = bankList[0].bankName
        bankBranchName.text = bankList[0].bankBranchName
        bankBranchCode.text = bankList[0].bankBranchCode
        accountType.text = bankList[0].bankAccountType
        accountNumber.text = bankList[0].bankAccountNum
        accountName.text = bankList[0].bankAccountName

    }

    override func viewWillAppear(_ animated: Bool) {
        compVM.bankParse(compId: comp?.compId ?? "") { data in
            self.bankList = data
        }
        
    }
    
    @IBAction func updateButton(_ sender: Any) {
        
    }


}
