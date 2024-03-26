//
//  CompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class CompanyTableViewController: UITableViewController {
    
    var compDelete = String()
    var buyListCount = [Buy]()
    let buyVM = BuyVM()
    
    var compList = [CompanyBank]()
    let compVM = CompanyVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 70.0
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
        
        getComp()
        getCompanyCount()
    }
    
    @IBAction func goToCompAdd(_ sender: Any) {
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comp = compList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompanyTableViewCell
        cell.companyNameLabel.text = comp.compName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToCompDet", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAct = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAct])
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.refreshControl!.isRefreshing {
            self.getComp()
            self.refreshControl!.endRefreshing()
        }
    }
    
    
    //MARK: - Helpers
    func showDeleteWarning(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Firmayı Silmek Üzeresiniz", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAct = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAct)
        let okAct = UIAlertAction(title: "Tamam", style: .destructive) { action in
            DispatchQueue.main.async {
                self.deleteComp(at: indexPath)
            }
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }
    
    
    func deleteComp(at indexPath: IndexPath) {
        let comp = self.compList[indexPath.row]
        if let cId = comp.cbId {
            if let intCId = Int(cId) {
                if let currentUser = Auth.auth().currentUser {
                    let uid = currentUser.uid
                    self.compVM.deleteCompany(userMail: uid, cbId: intCId)
                    self.compList.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCompDet" {
            guard let indeks = sender as? Int else { return }
            let goToVC = segue.destination as! CompanyDetailViewController
            goToVC.company = compList[indeks]
        }
    }
    
    func getComp() {
        
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            compVM.getAllCompany(userMail: uid) { compData in
                self.compList = compData
                if let dn = self.compList.first?.compName {
                    print(dn)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getCompanyCount() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            self.compVM.countCompBank(userMail: uid) { compCount in
                self.compList = compCount
                if let count = self.compList.first?.count {
                    if let intcomp = Int(count) {
                        if intcomp == 0 {
                            ProgressHUD.showSuccess("+ ile Firma ekleyerek uygulamayı kullanmaya başlayın.")
                        }
                    }
                }
            }
        }
    }
    
}
