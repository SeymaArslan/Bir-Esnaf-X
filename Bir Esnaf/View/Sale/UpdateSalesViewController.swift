//
//  UpdateSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class UpdateSalesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var selectProdComponent = String()
    var forSelectProdPickerList = [Product]()
    let prodVM = ProductVM()
    
    
    var prodSelect = String()
    var prodList = [Product]()
    
    let saleVM = SaleVM()
    var sale: Sale?
    
    @IBOutlet weak var prodName: UIPickerView!
    @IBOutlet weak var salePrice: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var buyDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prodName.delegate = self
        prodName.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSaleInformation()
        getCompList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let prodId = forSelectProdPickerList.first?.prodId {
            DispatchQueue.main.async {
                self.selectProdComponent = prodId
                if let intPId = Int(self.selectProdComponent) {
                    if intPId >= 2 {
                        let intLastPId = intPId - 1
                        if let prodStr = self.prodList[intLastPId].prodName {
                            self.prodSelect = prodStr
                        }
                        self.prodName.selectRow(intLastPId, inComponent: 0, animated: true)
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func salesUpdateButton(_ sender: Any) {
        
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
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
        if let select = prodList[row].prodName {
            prodSelect = select
        }
    }
    
    
    //MARK: - Helpers
    func getCompList() {
        saleVM.fetchProdList { prodData in
            self.prodList = prodData
            DispatchQueue.main.async {
                self.prodName.reloadAllComponents()
            }
        }
    }
    
    func getSaleInformation() {
        if let s = sale {
//            prodName.text = s.prodName
            salePrice.text = s.salePrice
            total.text = s.total
            totalPrice.text = s.totalPrice
            buyDateTextField.text = s.saleDate
            
            if let getSelectProd = s.prodName {
                prodVM.getSelectedProdPicker(prodName: getSelectProd) { prodData in
                    self.forSelectProdPickerList = prodData
                }
            }
            
        }
    }
    
}
