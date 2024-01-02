//
//  AddCompanyBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//  add için comp id alacağız servisi yazarken unutma

import UIKit
import ProgressHUD

class AddCompanyBankTableViewController: UITableViewController {
    
    let bankVm = BankVM()
    var userMail: String?
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
        addBank()
    }
    
    
    //MARK: - Helpers
    func addBank() {
        if let mail = userMail, let cId = compId, let bName = bankName.text, let bBranchName = bankBranchName.text, let bBranchCode = bankBranchCode.text, let aType = accountType.text, let aName = accountName.text, let aNumber = accountNumber.text, let iban = iban.text {
            bankVm.bankInsert(uMAil: mail, cId: cId, bName: bName, bBranchName: bBranchName, bBranchCode: bBranchCode, bAccType: aType, bAccName: aName, bAccNum: aNumber, bIban: iban)
            ProgressHUD.showSuccess("Banka bilgileri kayıt edildi.")
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
}
