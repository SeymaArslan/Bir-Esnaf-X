//
//  AddBuyViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import UIKit

class AddBuyViewController: UIViewController {

    @IBOutlet weak var compPicker: UIPickerView!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var buyDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBuy(_ sender: Any) {
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    
}
