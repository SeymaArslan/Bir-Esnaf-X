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

        compName.delegate = self
        compPhone.delegate = self
        compMail.delegate = self
        
        setupBackgroundTap()
        setupToolBar()
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
    
    //MARK: - Helpers
    func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        compPhone.inputAccessoryView = bar
    }
}

extension AddCompanyViewController: UITextFieldDelegate {

    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        compName.endEditing(true)
        compMail.endEditing(true)
        return true
    }
    
}
