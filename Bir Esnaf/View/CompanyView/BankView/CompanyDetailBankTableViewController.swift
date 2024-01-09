//
//  CompanyDetailBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
// gelmiyoreee bi bak compId üzerinden çek veriyi bide sorgu da eşitle..

import UIKit
import ProgressHUD

class CompanyDetailBankTableViewController: UITableViewController {
    
    var bankId: Int?
    let bankVM = BankVM()
    var bank: Bank?
    var compId: Int?
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBranchName: UITextField!
    @IBOutlet weak var bankBranchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var accountName: UITextField!
    
    @IBOutlet weak var iban: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBankData()
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        bankUpdate()
    }
    
    //MARK: - Helpers
    func getBank() {
        if let b = self.bank {
            DispatchQueue.main.async {
                self.bankName.text = b.bankName
                self.bankBranchName.text = b.bankBranchName
                self.bankBranchCode.text = b.bankBranchCode
                self.accountType.text = b.bankAccountType
                self.accountNumber.text = b.bankAccountNum
                self.accountName.text = b.bankAccountName
                self.iban.text = b.bankIban
                if let bId = b.bankId {
                    if let intBId = Int(bId) {
                        self.bankId = intBId
                    }
                }
            }
        }
    }
    
    
    func getBankData() {
        if let cId = compId {
            bankVM.bankParse(compId: cId) { bankList in
                self.bank = bankList.first
                self.getBank()
            }
        }
    }
    
    func bankUpdate() {
        if let bId = bankId, let bName = bankName.text, let bBranchName = bankBranchName.text, let bBCode = bankBranchCode.text, let aType = accountType.text, let aNum = accountNumber.text, let aName = accountName.text, let ibanBank = iban.text {
            if let accountNumber = Int(aNum) {
                bankVM.bankUpdate(bankId: bId, bankName: bName, bankBranchName: bBranchName, bankBranchCode: bBCode, bankAccountType: aType, bankAccountName: aName, bankAccountNum: accountNumber, bankIban: ibanBank)
                ProgressHUD.showSuccess("Banka bilgileri güncellendi.")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                ProgressHUD.showError("Hesap numarası sadece rakamlardan oluşmalıdır!")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
