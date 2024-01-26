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
    
    var compList = [CompanyBank]()
    var compSelect = String()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var compPickerUp: UIPickerView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var priceUp: UITextField!
    @IBOutlet weak var totalUp: UITextField!
    @IBOutlet weak var totalPriceUp: UITextField!

    @IBOutlet weak var buyDateUp: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compPickerUp.delegate = self
        compPickerUp.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCompList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !compList.isEmpty {
            if let selectPicker = compList[0].compName {
                compSelect = selectPicker
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
        }
    }
    
    func update() {
        
    }

    
}

