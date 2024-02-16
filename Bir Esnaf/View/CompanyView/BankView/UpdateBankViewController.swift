//
//  UpdateBankViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit
import ProgressHUD

class UpdateBankViewController: UIViewController {
    
//    public var completionHandler:(()->Void)?
    
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
        
        setupBackgroundTap()
        setupToolBar()
    }
    
    
    @IBAction func bankUpdateButton(_ sender: Any) {
        updateComp()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - Helpers
    func updateComp() {
        if let bName = bankName.text, let branchName = branchName.text, let branchCode = branchCode.text, let aType = accountType.text, let aName = accountName.text, let aNum = accountNumber.text, let iban = ibanNumber.text {
            if let intANum = Int(aNum) {
                compVM.compUpdate(cbId: compId, compName: cName, compPhone: cPhone, compMail: cMail, province: province, district: district, quarter: quarter, asbn: asbn, bankName: bName, bankBranchName: branchName, bankBranchCode: branchCode, bankAccountType: aType, bankAccountName: aName, bankAccountNum: intANum, bankIban: iban)
                
                ProgressHUD.showSuccess("Firma bilgileri güncellendi.")
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
    
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


extension UpdateBankViewController: UITextFieldDelegate {
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        branchCode.inputAccessoryView = bar
        accountNumber.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bankName.endEditing(true)
        branchName.endEditing(true)
        branchCode.endEditing(true)
        accountType.endEditing(true)
        accountName.endEditing(true)
        accountNumber.endEditing(true)
        ibanNumber.endEditing(true)
        return true
    }
}
