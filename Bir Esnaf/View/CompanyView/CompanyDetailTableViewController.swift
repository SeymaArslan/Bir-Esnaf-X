//
//  CompanyDetailTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit

class CompanyDetailTableViewController: UITableViewController {
    
    var company: Company?
    let compVM = CompanyVM()
    var bankId, compId : String?
    let bankVM = BankVM()
    var bankDatas = [Bank]()
    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCompanyDatas()
        getBank()
    }
    
    
    @IBAction func bankInfoButton(_ sender: Any) {
    }
    
    
    @IBAction func compUpdateButton(_ sender: Any) {
        compUpdate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBankDetail" {
            let goToBankDetVC = segue.destination as! CompanyDetailBankTableViewController
            goToBankDetVC.bankList = bankDatas
            goToBankDetVC.bankId = bankId
        }
    }
    
    //MARK: - Helpers
    func getCompanyDatas(){
        if let comp = company {
            compName.text = comp.compName
            compAddress.text = comp.compAddress
            compPhone.text = comp.compPhone
            compMail.text = comp.compMail
            bankId = comp.bankId
            compId = comp.compId
        }
    }
    
    func compUpdate() {
        if let cId = compId, let cName = compName.text, let cAdd = compAddress.text, let cPho = compPhone.text, let cMail = compMail.text {
            compVM.compUpdate(compId: cId, compName: cName, compAddress: cAdd, compPhone: cPho, compMail: cMail)
        }
    }
    
    func getBank() {
        if let id = bankId {
            bankVM.bankParse(bankId: Int(id)!) { bankDatas in
                self.bankDatas = bankDatas
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

