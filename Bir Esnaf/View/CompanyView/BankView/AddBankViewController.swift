//
//  AddBankViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class AddBankViewController: UIViewController {
    
    var cName = String()
    var cPhone = String()
    var cMail = String()
    var province = String()
    var district = String()
    var quarter = String()
    var asbn = String()
    
    let compVM = CompanyVM()
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var branchName: UITextField!
    @IBOutlet weak var branchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var ibanNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bankName.delegate = self
        branchName.delegate = self
        accountType.delegate = self
        accountName.delegate = self
        ibanNumber.delegate = self
        
        setupBackgroundTap()
        setupToolBar()
    }
    
    @IBAction func saveBankButton(_ sender: Any) {
        addComp()
        if let mainVC = presentingViewController as? CompanyTableViewController {
            DispatchQueue.main.async {
                mainVC.tableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    //MARK: - Helpers
    func addComp() {
        if let bName = bankName.text, let bBranchName = branchName.text, let bCode = branchCode.text, let aType = accountType.text, let aName = accountName.text, let aNumber = accountNumber.text, let iban = ibanNumber.text {
            
            if let intAccNum = Int(aNumber) {
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    compVM.companyInsert(userMail: uid, compName: cName, compPhone: cPhone, compMail: cMail, province: province, district: district, quarter: quarter, asbn: asbn, bankName: bName, bankBranchName: bBranchName, bankBranchCode: bCode, bankAccountType: aType, bankAccountName: aName, bankAccountNum: intAccNum, bankIban: iban)
                    
                    ProgressHUD.showSuccess("Firma kayıt edildi.")
                    self.view.window?.rootViewController?.dismiss(animated: true)
                }
            }
        }
    }
    
    
}

extension AddBankViewController: UITextFieldDelegate {
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
        accountType.endEditing(true)
        accountName.endEditing(true)
        ibanNumber.endEditing(true)
        return true
    }
}
