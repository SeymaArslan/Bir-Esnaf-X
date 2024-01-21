//
//  AddBankViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//  https://stackoverflow.com/questions/28706877/how-can-you-reload-a-viewcontroller-after-dismissing-a-modally-presented-view-co reload data için
// NOT Güncelleme işlemini de hallettikten sonra company bitiyor.. 

import UIKit
import ProgressHUD

class AddBankViewController: UIViewController {

    var cName = String()
    var cPhone = String()
    var cMail = String()
    var province = String()
    var district = String()
    var quarter = String()
    var asbn = String()
    
    let compVM = CompanyVM()
    let mail = userDefaults.string(forKey: "userMail")
    
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var branchName: UITextField!
    @IBOutlet weak var branchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var ibanNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Geldi mi province \(province)")
        

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
    
        if let email = mail, let bName = bankName.text, let bBranchName = branchName.text, let bCode = branchCode.text, let aType = accountType.text, let aName = accountName.text, let aNumber = accountNumber.text, let iban = ibanNumber.text {
            
            if let intAccNum = Int(aNumber) {
                compVM.companyInsert(userMail: email, compName: cName, compPhone: cPhone, compMail: cMail, province: province, district: district, quarter: quarter, asbn: asbn, bankName: bName, bankBranchName: bBranchName, bankBranchCode: bCode, bankAccountType: aType, bankAccountName: aName, bankAccountNum: intAccNum, bankIban: iban)
                
                ProgressHUD.showSuccess("Firma kayıt edildi.")
//                self.view.window!.rootViewController?.dismiss(animated: true, completion: {
//                    if let mainVC = self.presentingViewController as? CompanyTableViewController {
//                        DispatchQueue.global(qos: .userInitiated).async {
//                            mainVC.tableView.reloadData()
//                        }
//                    }
//                })
//                self.view.window!.rootViewController?.dismiss(animated: true, completion: {
//                    let compVC = CompanyTableViewController()
//                    compVC.getComp()
//                })
//                
                self.view.window?.rootViewController?.dismiss(animated: true)

            }
        }
        
        
    }

    
}
