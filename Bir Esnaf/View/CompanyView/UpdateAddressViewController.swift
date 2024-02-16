//
//  UpdateAddressViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//  yarına verileri bankaya gönder ardından tüm textleri update ile işle

import UIKit

class UpdateAddressViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var company: CompanyBank?
    
    var cName = String()
    var cPhone = String()
    var cMail = String()
    
    var provinceList = [Province]()
    var provinceSelect = String()
    let pm = ProvinceVM()
    var getProvList = [Province]()
    var provinceComponent = String()

    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var districtUpdate: UITextField!
    @IBOutlet weak var quarterUpdate: UITextField!
    @IBOutlet weak var fullAddressUpdate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        setupBackgroundTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCompany()
        getProvince()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let pID = getProvList.first?.pId {
            DispatchQueue.main.async {
                self.provinceComponent = pID
                if let intPId = Int(self.provinceComponent) {
                    let intLastPId = intPId - 1
                    if let provString = self.provinceList[intLastPId].province {
                        self.provinceSelect = provString
                    }
                    self.cityPicker.selectRow(intLastPId, inComponent: 0, animated: true)
                }
            }
        }
    }

    
    @IBAction func bankUpdateButton(_ sender: Any) {
        
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
        }
    }
    
    
    //MARK: - Helpers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bankUpdate" {
            let goToBank = segue.destination as! UpdateBankViewController
            goToBank.cName = cName
            goToBank.cPhone = cPhone
            goToBank.cMail = cMail
            goToBank.province = provinceSelect
            if let dist = districtUpdate.text, let quart = quarterUpdate.text, let asbn = fullAddressUpdate.text {
                goToBank.district = dist
                goToBank.quarter = quart
                goToBank.asbn = asbn
            }
            goToBank.company = company
        }
    }
    
    func getCompany() {
        if let comp = company {
            districtUpdate.text = comp.district
            quarterUpdate.text = comp.quarter
            fullAddressUpdate.text = comp.asbn
            if let getProv = comp.province {
                pm.getSelectedProvince(province: getProv) { [self] provData in
                    self.getProvList = provData

                }
            }
        }
    }
    
    func getProvince() {
        pm.getProvince { provDatas in
            self.provinceList = provDatas
            DispatchQueue.main.async {
                self.cityPicker.reloadAllComponents()
            }
        }
    }
    
}


extension UpdateAddressViewController: UITextFieldDelegate {
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        districtUpdate.endEditing(true)
        quarterUpdate.endEditing(true)
        fullAddressUpdate.endEditing(true)
        return true
    }
}
