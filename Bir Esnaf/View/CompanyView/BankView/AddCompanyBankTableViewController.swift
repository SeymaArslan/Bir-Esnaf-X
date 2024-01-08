//
//  AddCompanyBankTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//  add için comp id alacağız servisi yazarken unutma

import UIKit
import ProgressHUD

class AddCompanyBankTableViewController: UITableViewController {
    var bankListId = [Bank]()
    let bankVM = BankVM()
    let compVM = CompanyVM()
    var userMail: String?
    var compId: Int?
    var bankId: Int?
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var bankBranchName: UITextField!
    @IBOutlet weak var bankBranchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var iban: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLastBankId()
    }

    
    @IBAction func saveBankButton(_ sender: Any) {
        addBank()
    }
    
    
    //MARK: - Helpers
    func getLastBankId() {
        bankVM.getLastBankId { getLastId in
            self.bankListId = getLastId
            DispatchQueue.main.async {
                if let id = self.bankListId.first?.bankId {
                    self.bankId = Int(id)
                }
            }
        }
    }
    
    func updateBankId() {
        if let cId = self.compId, let bId = self.bankId {
            self.compVM.updateBankId(compId: cId, bankId: bId + 1)
        } else {
            self.compVM.updateBankId(compId: 1, bankId: 1)
        }
    }
    
    func addBank() {
        if let mail = userMail, let cId = compId, let bName = bankName.text, let bBranchName = bankBranchName.text, let bBranchCode = bankBranchCode.text, let aType = accountType.text, let aName = accountName.text, let aNumber = accountNumber.text, let iban = iban.text {
            if let accountNumber = Int(aNumber) {
                bankVM.bankInsert(uMAil: mail, cId: cId, bName: bName, bBranchName: bBranchName, bBranchCode: bBranchCode, bAccType: aType, bAccName: aName, bAccNum: accountNumber, bIban: iban)
                ProgressHUD.showSuccess("Banka bilgileri kayıt edildi.")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                ProgressHUD.showError("Hesap numarası sadece rakamlardan oluşmalıdır!")
            }
        }
        updateBankId()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
}
