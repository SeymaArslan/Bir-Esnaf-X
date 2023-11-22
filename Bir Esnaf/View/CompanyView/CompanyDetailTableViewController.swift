//
//  CompanyDetailTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit

class CompanyDetailTableViewController: UITableViewController {

    var company: Company?
    
//    var picker: YPImagePicker?
    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compLogo: UIImageView!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        compName.text = company?.compName
        if let url = URL(string: "https://lionelo.tech/birEsnafImages/\(company?.compLogoURL ?? "default.png")") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.compLogo.image = UIImage(data: data!)
                }
            }
        }
        compAddress.text = company?.compAddress
        compPhone.text = company?.compPhone
        compMail.text = company?.compMail
        
//        setupPicker()
        
    }

    @IBAction func compLogoEditButton(_ sender: Any) {
        // burası için kütüphaneti incele sadece adını alacağız ve company.compId ve o adla güncelleme yapacağız. kullanacağımız dosya compLogoUpdate
    }
    
    @IBAction func bankInfoButton(_ sender: Any) {
        // burada bankId gönderip CompanyDetailBankTableViewController a yönlendireceğiz.
    }
    
    @IBAction func compUpdateButton(_ sender: Any) {
        // burada textlerin vs değişiklikleri olursa güncelleme yapacağız kullanacağımız dosya compUpdate.php
    }
    


}
