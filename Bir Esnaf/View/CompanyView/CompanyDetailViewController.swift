//
//  CompanyDetailViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class CompanyDetailViewController: UIViewController {

    var company: CompanyBank?
    var compId: String?
    
    @IBOutlet weak var compName: UILabel!
    @IBOutlet weak var compPhone: UILabel!
    @IBOutlet weak var compEmail: UILabel!
    @IBOutlet weak var compTotalAddress: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var bankIban: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var branchCode: UILabel!
    @IBOutlet weak var branchName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCompanyDatas()
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
    }
    
   
    //MARK: - Helpers
    func getCompanyDatas(){
        if let comp = company {
            compName.text = comp.compName
            compPhone.text = comp.compPhone
            compEmail.text = comp.compMail
            if let asbn = comp.asbn, let quarter = comp.quarter, let district = comp.district, let province = comp.province {
                compTotalAddress.text = asbn + " " + quarter + " " + district + " " + province
            }
            bankName.text = comp.bankName
            bankIban.text = comp.bankIban
            accountNumber.text = comp.bankAccountNum
            accountName.text = comp.bankAccountName
            branchCode.text = comp.bankBranchCode
            branchName.text = comp.bankBranchName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "compUpdate" {
            let goToVC = segue.destination as! UpdateCompanyViewController 
            goToVC.company = company
        }
    }

}
