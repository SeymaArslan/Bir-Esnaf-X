//
//  AddCompanyViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class AddCompanyViewController: UIViewController {

    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func compSaveButton(_ sender: Any) {

    }
    
    @IBAction func compCancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAddress" {
            let goToAddressVC = segue.destination as! AddAddressViewController
            if let cName = compName.text, let cPhone = compPhone.text, let cMail = compMail.text {
                goToAddressVC.cName = cName
                goToAddressVC.cPhone = cPhone
                goToAddressVC.cMail = cMail
            }
        }
    }

    
}
