//
//  UpdateAddressViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.01.2024.
//

import UIKit

class UpdateAddressViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cName = String()
    var cPhone = String()
    var cMail = String()
    
    var provinceList = [Province]()
    var provinceSelect = String()
    let pm = ProvinceVM()

    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var districtUpdate: UITextField!
    @IBOutlet weak var quarterUpdate: UITextField!
    @IBOutlet weak var fullAddressUpdate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        print("update adress compName = \(cName) ")
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
            print(provinceSelect)
        }
    }
    
    
    
    //MARK: - Helpers
    func getProvince() {
        pm.getProvince { provDatas in
            self.provinceList = provDatas
            DispatchQueue.main.async {
                self.cityPicker.reloadAllComponents()
            }
        }
    }
    
}
