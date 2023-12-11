//
//  AddCompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit
import YPImagePicker

class AddCompanyTableViewController: UITableViewController {

    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    @IBOutlet weak var goToSaveBankButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveCompButton(_ sender: Any) {
        self.goToSaveBankButtonOutlet.isHidden = false
    }
    
    @IBAction func goToBankButton(_ sender: Any) {

        performSegue(withIdentifier: "addBankInfo", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBankInfo" {
            
        }
    }
    
    //MARK: - Helpers

    
}
