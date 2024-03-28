//
//  AddProductViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 8.01.2024.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class AddProductViewController: UIViewController {
    
    let prodVM = ProductVM()
    
    @IBOutlet weak var prodName: UITextField!
    @IBOutlet weak var prodPrice: UITextField!
    @IBOutlet weak var prodTotal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prodName.delegate = self
        
        setupToolBar()
        setupBackgroundTap()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveProd(_ sender: Any) {
        addProd()
    }
    
    
    func addProd() {
        var price = prodPrice.text
        price = price?.replacingOccurrences(of: ",", with: ".")
        
        var total = prodTotal.text
        total = total?.replacingOccurrences(of: ",", with: ".")
        
        if let pName = prodName.text, let pPrice = price, let pTotal = total {
            if let doublePrice = Double(pPrice), let doubleTotal = Double(pTotal) {
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    prodVM.insertProd(userMail: uid, prodName: pName, prodTotal: doubleTotal, prodPrice: doublePrice)
                    ProgressHUD.showSuccess("Ürün başarılı bir şekilde eklendi.")
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}



extension AddProductViewController: UITextFieldDelegate {
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        prodPrice.inputAccessoryView = bar
        prodTotal.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        prodName.endEditing(true)
        return true
    }
}
