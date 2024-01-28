//
//  UpdateBuyViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import UIKit

class UpdateBuyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: - Variable
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
        
//        getBuy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCompList()
        getBuy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let compId = getPickerCompList.first?.cbId {
            DispatchQueue.main.async {
                self.compComponent = compId
                if let intCId = Int(self.compComponent) {
                    if intCId >= 2 {
                        let intLastCId = intCId - 1
                        if let compString = self.compList[intLastCId].compName {  // burada hata atıyor
                            self.compSelect = compString
                        }
                        self.compPickerUp.selectRow(intLastCId, inComponent: 0, animated: true)
                    }
                    else {
                        if let compString = self.compList[intCId].compName {  // burada hata atıyor
                            self.compSelect = compString
                        }
                        self.compPickerUp.selectRow(intCId, inComponent: 0, animated: true)
                    }
                }
            }
        }
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
    func getCompList() {
        buyVM.fetchCompList { compData in
            self.compList = compData
            DispatchQueue.main.async {
                self.compPickerUp.reloadAllComponents()
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
                compVM.getSelectedCompPicker(compName: getComp) { [self] compData in
                    self.getPickerCompList = compData
                }
            }
        }
    }
    
    func update() {
        if let pName = productName.text, let price = priceUp.text, let total = totalUp.text, let tPrice = totalPriceUp.text, let date = buyDateUp.text {
            if let doublePrice = Double(price), let doubleTotal = Double(total), let doubleTPrice = Double(tPrice) {
                buyVM.updateBuy(buyId: buyId, compName: compSelect, productName: pName, price: doublePrice, total: doubleTotal, totalPrice: doubleTPrice, buyDate: date)
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
    }

    
}

