//
//  CompanyDetailBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
// bumu

import UIKit

class CompanyDetailBankTableViewController: UITableViewController {
    
    var bankId: Int?
    let bankVM = BankVM()
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

        
        
        getBank()
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        bankUpdate()
    }
    
    //MARK: - Helpers
    func getBank() {
        if let bankData = bank { // compName.text = comp.compName
            bankName.text = bankData.bankName 
            bankBranchName.text = bankData.bankBranchName
            bankBranchCode.text = bankData.bankBranchCode
            accountType.text = bankData.bankAccountType
            accountNumber.text = bankData.bankAccountNum
            accountName.text = bankData.bankAccountName
            iban.text = bankData.bankIban
        }
    }
    
    func getBankData() {
        
    }
    
    func bankUpdate() {
        if let bId = bankId, let bName = bankName.text, let bBranchName = bankBranchName.text, let bBCode = bankBranchCode.text, let aType = accountType.text, let aNum = accountNumber.text, let aName = accountName.text, let ibanBank = iban.text {
            print(bId)
            bankVM.bankUpdate(bankId: bId, bankName: bName, bankBranchName: bBranchName, bankBranchCode: bBCode, bankAccountType: aType, bankAccountName: aName, bankAccountNum: aNum, bankIban: ibanBank)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
