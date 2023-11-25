//
//  CompanyDetailTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//      *** servis url lerini düzenle sonra dene!!!

import UIKit
import YPImagePicker

class CompanyDetailTableViewController: UITableViewController {

    var company: Company?
    let compVM = CompanyVM()

    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compLogo: UIImageView!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextField!
    
    var picker: YPImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupPicker()
        
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
        showPicker()
    }
    
    @IBAction func bankInfoButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToBankDetail", sender: self)
    }
    
    @IBAction func compUpdateButton(_ sender: Any) {
        compVM.compUpdate(compId: (company?.compId!)!, compName: compName.text!, compAddress: compAddress.text!, compPhone: compPhone.text!, compMail: compMail.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToBankDetail") {
            let bankDetVC = segue.destination as! CompanyDetailBankTableViewController
            bankDetVC.comp = company
        }
    }
    
    //MARK: - Helpers
    func setupPicker() {
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = false
        config.screens = [.library]
        
        config.library.maxNumberOfItems = 3
        
        picker = YPImagePicker(configuration: config)
    }
    
    func showPicker() {
        guard let picker = picker else { return }
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                print("Picker was canceled")
            }
            for item in items {
                switch item {
                case .photo(p: let photo):
                    DispatchQueue.main.async {
                        self.compLogo.image = photo.image
                    }
                case .video(v: let video):
                    print(video)  // video koyulamayacağı ile ilgili uyarı göster.
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }


}
