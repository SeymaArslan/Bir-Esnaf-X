//
//  ShoppingViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//

import UIKit

class ShoppingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let profVM = ProfitVM()
    let visible = false // eğer sale tablosu boşsa false doluysa true yapıp UI ları göstereceğiz?
    
    var saleSelect = String()
    var saleList = [Sale]()
    let mail = userDefaults.string(forKey: "userMail")
    let saleVM = SaleVM()
    
    @IBOutlet weak var salePicker: UIPickerView!
    @IBOutlet weak var profitAmount: UILabel!
    @IBOutlet weak var totalProfitAmount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profitAmount.text = "0 ₺"
        totalProfitAmount.text = "0 ₺"
        
        salePicker.delegate = self
        salePicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSale()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !saleList.isEmpty {
            if let selectPicker = saleList[0].prodName {
                saleSelect = selectPicker
            }
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        
    }
    
    
    //MARK: - Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return saleList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return saleList[row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerSelect = saleList[row].prodName {
            saleSelect = pickerSelect
            print(saleSelect)
        }
    }
    
    
    //MARK: - Helpers
    func getProfit() {
        DispatchQueue.main.async {
            
        }
    }
    
    func fetchSale() {
        saleVM.getSaleList(mail: mail!) { saleList in
            self.saleList = saleList
            DispatchQueue.main.async {
                self.salePicker.reloadAllComponents()
            }
        }
    }


}
