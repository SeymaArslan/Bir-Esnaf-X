//
//  AddAddressViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class AddAddressViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var cName = String()
    var cPhone = String()
    var cMail = String()
    
    var provinceList = [Province]()
    var provinceSelect = String()
    let pm = ProvinceVM()
    
    @IBOutlet weak var provincePicker: UIPickerView!
    @IBOutlet weak var compDistrict: UITextField!
    @IBOutlet weak var compQuarter: UITextField!
    @IBOutlet weak var compFullAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        provincePicker.delegate = self
        provincePicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProvince()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !provinceList.isEmpty {
            if let provString = provinceList[0].province {
                provinceSelect = provString
            }
        }
    }
    
    @IBAction func saveCompAddress(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return provinceList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return provinceList[row].province
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let provString = provinceList[row].province {
            provinceSelect = provString
            print(provinceSelect)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBank" {
            let goToAddBankVC = segue.destination as! AddBankViewController
            if let district = compDistrict.text, let quarter = compQuarter.text, let asbn = compFullAddress.text {
                goToAddBankVC.cName = cName
                goToAddBankVC.cPhone = cPhone
                goToAddBankVC.cMail = cMail
                goToAddBankVC.province = provinceSelect
                goToAddBankVC.district = district
                goToAddBankVC.quarter = quarter
                goToAddBankVC.asbn = asbn
            }
        }
    }
    
    
    //MARK: - Helpers
    func getProvince() {
        pm.getProvince { provDatas in
            self.provinceList = provDatas
            DispatchQueue.main.async {
                self.provincePicker.reloadAllComponents()
            }
        }
    }
    
}
