//
//  AddSalesViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import UIKit

class AddSalesViewController: UIViewController {

    
    @IBOutlet weak var prodPicker: UIPickerView!
    @IBOutlet weak var salePrice: UITextField!
    @IBOutlet weak var totalStepperLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var totalPrice: UITextField!
// buraya yine label ile tarih ekle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func saveSaleButton(_ sender: Any) {
        
    }
    
    
    @IBAction func dismissButton(_ sender: Any) {
        
    }
    
}
