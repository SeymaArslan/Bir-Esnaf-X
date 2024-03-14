//
//  UpdateBuyViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import UIKit
import ProgressHUD

class UpdateBuyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: - Variable
    var selectCompComponent = String()
    let mail = userDefaults.string(forKey: "userMail")
    
    var buy: Buy?
    let buyVM = BuyVM()
    var buyId = Int()
    
    var compList = [CompanyBank]()
    var compSelect = String()
    var compComponent = String()
    let compVM = CompanyVM()
    var getPickerCompList = [CompanyBank]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var compPickerUp: UIPickerView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var priceUp: UITextField!
    @IBOutlet weak var totalUp: UITextField!
    @IBOutlet weak var totalPriceUp: UITextField!
    @IBOutlet weak var buyDateUp: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compPickerUp.delegate = self
        compPickerUp.dataSource = self
        
        productName.delegate = self
        
        setupToolBar()
        setupBackgroundTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCompList()
        getBuy()
    }
    
    //MARK: - IBActions
    @IBAction func updateButton(_ sender: Any) {
        update()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - Delegate and DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return compList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return compList[row].compName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerSelect = compList[row].compName {
            compSelect = pickerSelect
        }
    }
    
    
    //MARK: - Helpers
    func updatePickerStatus(enabled: Bool) {
        compPickerUp.isUserInteractionEnabled = enabled
        compPickerUp.alpha = enabled ? 1.0 : 0.5
    }
    
    
    func getCompList() {
        buyVM.fetchCompList { compData in
            self.compList = compData
            DispatchQueue.main.async {
                self.compPickerUp.reloadAllComponents()
                if let selectedIndex = self.compList.firstIndex(where: { $0.compName == self.compSelect}) {
                    self.compPickerUp.selectRow(selectedIndex, inComponent: 0, animated: true)
                }
                let compNameExists = self.compList.contains(where: { $0.compName == self.compSelect })
                self.updatePickerStatus(enabled: compNameExists)
            }
        }
    }
    
    
    func getBuy() {
        if let buyData = buy {
            productName.text = buyData.productName
            priceUp.text = buyData.price
            totalUp.text = buyData.total
            totalPriceUp.text = buyData.totalPrice
            buyDateUp.text = buyData.buyDate
            if let id = buyData.buyId {
                if let intId = Int(id) {
                    buyId = intId
                }
            }
            if let getComp = buyData.compName {
                compSelect = getComp
                compVM.getSelectedCompPicker(compName: getComp) { compData in
                    self.getPickerCompList = compData
                    if let selected = self.getPickerCompList.first?.compName {
                        self.selectCompComponent = selected
                        DispatchQueue.main.async {
                            self.compPickerUp.reloadAllComponents()
                        }
                    }
                }
            }
        }
    }
    
    func update() {
        var priceRep = priceUp.text
        priceRep = priceRep?.replacingOccurrences(of: ",", with: ".")
        var totalRep = totalUp.text
        totalRep = totalRep?.replacingOccurrences(of: ",", with: ".")
        var totalPriceRep = totalPriceUp.text
        totalPriceRep = totalPriceRep?.replacingOccurrences(of: ",", with: ".")
        if let pName = productName.text, let price = priceRep, let total = totalRep, let tPrice = totalPriceRep, let date = buyDateUp.text {
            if let doublePrice = Double(price), let doubleTotal = Double(total), let doubleTPrice = Double(tPrice) {
                buyVM.updateBuy(userMail: mail!, buyId: buyId, compName: compSelect, productName: pName, price: doublePrice, total: doubleTotal, totalPrice: doubleTPrice, buyDate: date)
                ProgressHUD.showSuccess("Satın alma bilgisi güncellendi.")
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }
}

extension UpdateBuyViewController: UITextFieldDelegate {
    private func setupToolBar() {
        let bar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()

        priceUp.inputAccessoryView = bar
        totalUp.inputAccessoryView = bar
        totalPriceUp.inputAccessoryView = bar
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        productName.endEditing(true)
        return true
    }
}
