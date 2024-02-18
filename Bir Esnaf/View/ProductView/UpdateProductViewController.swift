//
//  UpdateProductViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 22.01.2024.
//

import UIKit
import ProgressHUD

class UpdateProductViewController: UIViewController {
    
    let prodVM = ProductVM()
    var prodId = Int()
    var product: Product?
    
    @IBOutlet weak var prodNameUp: UITextField!
    @IBOutlet weak var prodPriceUp: UITextField!
    @IBOutlet weak var prodTotalUp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProd()
        
        prodNameUp.delegate = self
        
        setupToolBar()
        setupBackgroundTap()
    }
    
    @IBAction func updateProduction(_ sender: Any) {
        updateProd()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - Helpers
    func getProd() {
        if let prod = product {
            prodNameUp.text = prod.prodName
            prodPriceUp.text = prod.prodPrice
            prodTotalUp.text = prod.prodTotal
            if let id = prod.prodId {
                if let intId = Int(id) {
                    prodId = intId
                }
            }
        }
    }
    
    func updateProd() {
        var priceUpdate = prodPriceUp.text
        priceUpdate = priceUpdate?.replacingOccurrences(of: ",", with: ".")
        var totalUpdate = prodTotalUp.text
        totalUpdate = totalUpdate?.replacingOccurrences(of: ",", with: ".")
        if let pName = prodNameUp.text, let pPrice = priceUpdate, let pTotal = totalUpdate {
            if let doublePrice = Double(pPrice), let doubTotal = Double(pTotal) {
                prodVM.updateProd(prodId: prodId, prodName: pName, prodTotal: doubTotal, prodPrice: doublePrice)
                ProgressHUD.showSuccess("Ürün güncellendi.")
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
    
}


extension UpdateProductViewController: UITextFieldDelegate {
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        prodPriceUp.inputAccessoryView = bar
        prodTotalUp.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        prodNameUp.endEditing(true)
        return true
    }
}
