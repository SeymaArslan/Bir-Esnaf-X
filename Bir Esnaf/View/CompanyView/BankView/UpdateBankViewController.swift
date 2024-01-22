//
//  UpdateBankViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class UpdateBankViewController: UIViewController {
    
    let compVM = CompanyVM()
    
    var cName = String()
    var cPhone = String()
    var cMail = String()
    var province = String()
    var district = String()
    var quarter = String()
    var asbn = String()
    
    var company: CompanyBank?
    var compId = Int()
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var branchName: UITextField!
    @IBOutlet weak var branchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var ibanNumber: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCompData()
    }
    
    @IBAction func bankUpdateButton(_ sender: Any) {
        if let bName = bankName.text, let branchName = branchName.text, let branchCode = branchCode.text, let aType = accountType.text, let aName = accountName.text, let aNum = accountNumber.text, let iban = ibanNumber.text {
            if let intANum = Int(aNum) {
                compVM.compUpdate(cbId: compId, compName: cName, compPhone: cPhone, compMail: cMail, province: province, district: district, quarter: quarter, asbn: asbn, bankName: bName, bankBranchName: branchName, bankBranchCode: branchCode, bankAccountType: aType, bankAccountName: aName, bankAccountNum: intANum, bankIban: iban)
            }
        }
    }
    
   
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - Helpers
    func getCompData() {
        if let comp = company {
            bankName.text = comp.bankName
            branchName.text = comp.bankBranchName
            branchCode.text = comp.bankBranchCode
            accountType.text = comp.bankAccountType
            accountName.text = comp.bankAccountName
            accountNumber.text = comp.bankAccountNum
            ibanNumber.text = comp.bankIban
            if let id = comp.cbId {
                if let intId = Int(id) {
                    compId = intId
                }
            }
        }
    }
    
    
}
