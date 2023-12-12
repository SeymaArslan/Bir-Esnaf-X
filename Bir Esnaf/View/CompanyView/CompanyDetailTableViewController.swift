//
//  CompanyDetailTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//      *** servis url lerini düzenle sonra dene!!!

import UIKit

class CompanyDetailTableViewController: UITableViewController {

    var company: Company?
    let compVM = CompanyVM()

    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let n = company {
            compName.text = company?.compName
            compAddress.text = company?.compAddress
            compPhone.text = company?.compPhone
            compMail.text = company?.compMail
        }
        
    }
    
    
    @IBAction func bankInfoButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToBankDetail", sender: self)
    }
    
    @IBAction func compUpdateButton(_ sender: Any) {
        compVM.compUpdate(compId: (company?.compId!)!, compName: compName.text!, compAddress: compAddress.text!, compPhone: compPhone.text!, compMail: compMail.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToBankDetail") {
            let bankDetVC = segue.destination as! CompanyDetailBankTableViewController
            bankDetVC.comp = company
        }
    }
    
    //MARK: - Helpers



}
