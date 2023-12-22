//
//  CompanyDetailBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit

class CompanyDetailBankTableViewController: UITableViewController {

    var company: Company?
    var compId: String?
    var bank: Bank?
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBranchName: UITextField!
    @IBOutlet weak var bankBranchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var accountName: UITextField!
    
    @IBOutlet weak var iban: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBankInfo()
    }
    
    @IBAction func updateButton(_ sender: Any) {
//        compVM.bankUpdate(bankId: bankList[0].bankId!, bankName: bankName.text!, bankBranchName: bankBranchName.text!, bankBranchCode: bankBranchCode.text!, bankAccountType: accountType.text!, bankAccountName: accountName.text!, bankAccountNum: accountNumber.text!, bankIban: iban.text!)
    }

    //MARK: - Helpers
    func getBankInfo() {
        for b in bank ?? [] {
            bankName.text = bank.bankName
            bankBranchName.text = bank.bankBranchName
            bankBranchCode.text = bank.bankBranchCode
            accountType.text = bank.bankAccountType
            accountNumber.text = bank.bankAccountNum
            accountName.text = bank.bankAccountName
        }
    }
    

    
}
