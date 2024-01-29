//
//  AddSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class AddSalesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let mail = userDefaults.string(forKey: "userMail")
    let saleVM = SaleVM()
    
    var prodSelect = String()
    var prodList = [Product]()
    var date = String()
    
    
    //MARK: - IB Outlets
    @IBOutlet weak var prodPicker: UIPickerView!
    @IBOutlet weak var salePrice: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var saleDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prodPicker.delegate = self
        prodPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProd()
    }
    
    //MARK: - IB Actions
    @IBAction func saveSaleButton(_ sender: Any) {
        
    }
    
    
    @IBAction func dismissButton(_ sender: Any) {
        
    }
    
    
    //MARK: - Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prodList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return prodList[row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerSelect = prodList[row].prodName {
            prodSelect = pickerSelect
            print(prodSelect)
        }
    }
    
    
    //MARK: - Helpers
    func fetchProd() {
        saleVM.fetchProdList { prodData in
            self.prodList = prodData
            DispatchQueue.main.async {
                self.prodPicker.reloadAllComponents()
            }
        }
    }
    
}
