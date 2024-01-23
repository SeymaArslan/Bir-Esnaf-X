//
//  AddProductViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit

class AddProductViewController: UIViewController {

    let prodVM = ProductVM()
    let mail = userDefaults.string(forKey: "userMail")
    
    @IBOutlet weak var prodName: UITextField!
    @IBOutlet weak var prodPrice: UITextField!
    @IBOutlet weak var prodTotal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    

    @IBAction func saveProd(_ sender: Any) {
        if let userMail = mail ,let pName = prodName.text, let pPrice = prodPrice.text, let pTotal = prodTotal.text {
            if let doublePrice = Double(pPrice), let intTotal = Int(pTotal) {
                prodVM.insertProd(userMail: userMail, prodName: pName, prodTotal: intTotal, prodPrice: doublePrice)
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
    
}
