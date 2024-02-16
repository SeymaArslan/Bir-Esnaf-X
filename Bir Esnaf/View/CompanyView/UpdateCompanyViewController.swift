//
//  UpdateCompanyViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class UpdateCompanyViewController: UIViewController {

    var company: CompanyBank?
    
    @IBOutlet weak var compNameUpdate: UITextField!
    @IBOutlet weak var compPhoneUpdate: UITextField!
    @IBOutlet weak var compEmailUpdate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCompDatas()
        setupBackgroundTap()
        setupToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func compUpdateButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    //MARK: - Helpers
    func getCompDatas() {
        if let comp = company {
            compNameUpdate.text = comp.compName
            compPhoneUpdate.text = comp.compPhone
            compEmailUpdate.text = comp.compMail
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addressUpdate" {
            let goToVc = segue.destination as! UpdateAddressViewController
            if let cName = compNameUpdate.text, let cPhone = compPhoneUpdate.text, let cEmail = compEmailUpdate.text {
                goToVc.cName = cName
                goToVc.cPhone = cPhone
                goToVc.cMail = cEmail
                goToVc.company = company
            }
        }
    }
}



extension UpdateCompanyViewController: UITextFieldDelegate {
    private func setupToolBar() {
        let barItem = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        barItem.items = [flexSpace, flexSpace, doneButton]
        compPhoneUpdate.inputAccessoryView = barItem
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        compNameUpdate.endEditing(true)
        compEmailUpdate.endEditing(true)
        return true
    }
}
