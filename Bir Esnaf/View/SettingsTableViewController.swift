//
//  SettingsTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import UIKit
import ProgressHUD

class SettingsTableViewController: UITableViewController {

    //MARK: - Life Cylces
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showUserInfo() // refresh our page
    }
    
    
    //MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "backgroundColor")
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 12.0
    }
    
    
    @IBAction func tellAFriendButton(_ sender: Any) {
        let textToShare = String(describing: "Bir Esnaf")
        guard let appURLToShare = URL(string: "https://www.google.com"), let image = UIImage(named: "logo.png") else {   //  ********** URL olarak app url i vermeyi unutma
            return
        }
        
        let items = [textToShare, appURLToShare, image] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        avc.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList
        ]
    
        if UIDevice.current.userInterfaceIdiom == .pad {
            if avc.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                avc.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
            }
        }
        self.present(avc, animated: true, completion: nil)
    }
    
    
    @IBAction func termsAndCondButton(_ sender: Any) {
        let alert = UIAlertController(title: "Şartlar ve koşullar", message: "Linke gidiniz, Link: https://www.google.com", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        FirebaseUserListener.shared.logOutCurrentUser { error in
            if error == nil {
                let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func deleteAccountButton(_ sender: Any) {
        FirebaseUserListener.shared.deleteAccountCurrentUser { error in
            if error == nil {
                ProgressHUD.showSuccess("Hesabınız Silindi.")
                let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    //MARK: - UpdateUI
    private func showUserInfo() {
        if let user = User.currentUser {
            // burada yenileyeceğimiz şeyleri koyacağız işine yaramazsa sil geç. Ki bence kişi hesabı silerse login kayıt sayfasına yönlendirebiliriz.
        }
    }

    
}
