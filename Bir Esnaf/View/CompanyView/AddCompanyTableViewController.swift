//
//  AddCompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit
import ProgressHUD

class AddCompanyTableViewController: UITableViewController {
    
    var cId = String()
    var compListId = [Company]()
    var compList = [Company]()
    let mail = userDefaults.string(forKey: "userMail")
    let compVM = CompanyVM()
    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    @IBOutlet weak var goToSaveBankButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(compListId)
        getCompId()
    }
    
    @IBAction func saveCompButton(_ sender: Any) {
        goToSaveBankButtonOutlet.isEnabled = true
        addCompany()
        
    }
    
    @IBAction func goToBankButton(_ sender: Any) {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBankInfo" {
            let goToAddBankVC = segue.destination as! AddCompanyBankTableViewController
            goToAddBankVC.userMail = mail
            goToAddBankVC.compId = Int(cId)! + 1
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Helpers
    
    func getCompId() {
        compVM.getLastCompId { getId in
            self.compListId = getId
            DispatchQueue.main.async {
                if let id = self.compListId.first?.compId {
                    self.cId = id
                }
            }
        }
    }
    
    func addCompany() {
        if let uMail = mail, let cName = compName.text, let cAddress = compAddress.text, let cPhone = compPhone.text, let cMail = compMail.text {
            compVM.compInsert(userMail: uMail, compName: cName, compAddress: cAddress, compPhone: cPhone, compMail: cMail)
        }
        ProgressHUD.showSuccess("Firma başarılı bir şekilde kaydedildi.")
    }

    
}
