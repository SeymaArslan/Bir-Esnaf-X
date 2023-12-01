//
//  AddCompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 21.11.2023.
//

import UIKit
import YPImagePicker

class AddCompanyTableViewController: UITableViewController {

    
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compLogo: UIImageView!
    @IBOutlet weak var compAddress: UITextView!
    @IBOutlet weak var compPhone: UITextField!
    @IBOutlet weak var compMail: UITextView!
    
    @IBOutlet weak var goToSaveBankButtonOutlet: UIButton!
    
    
    var picker: YPImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupPicker()
    }

    @IBAction func compLogoEditButton(_ sender: Any) {
        showPicker()
    }
    
    
    @IBAction func saveCompButton(_ sender: Any) {
        self.goToSaveBankButtonOutlet.isHidden = false
    }
    
    @IBAction func goToBankButton(_ sender: Any) {
        
        
        performSegue(withIdentifier: "addBankInfo", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBankInfo" {
            
        }
    }
    
    //MARK: - Helpers
    func setupPicker() {
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = false
        config.screens = [.library]
        
        config.library.maxNumberOfItems = 3  // or 1? search the library
        
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
