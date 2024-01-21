//
//  UpdateBankViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class UpdateBankViewController: UIViewController {
    
    @IBOutlet weak var bankName: UITextField!
    @IBOutlet weak var branchName: UITextField!
    @IBOutlet weak var branchCode: UITextField!
    @IBOutlet weak var accountType: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var ibanNumber: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bankUpdateButton(_ sender: Any) {
        
        
    }
    
   
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    // addressUpdate
}
