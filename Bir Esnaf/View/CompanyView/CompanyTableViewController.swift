//
//  CompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import UIKit

class CompanyTableViewController: UITableViewController {
    
    var buyListCount = [Buy]()
    let buyVM = BuyVM()
    
    var compList = [CompanyBank]()
    let mail = userDefaults.string(forKey: "userMail")
    let compVM = CompanyVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = 70.0
        
        self.refreshControl = UIRefreshControl()
        self.tableView.refreshControl = self.refreshControl
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        getComp()
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
                self.companyBuyControl(at: indexPath)         //   TEST 
            }
        }
        alertController.addAction(okAct)
        self.present(alertController, animated: true)
    }

    
    func deleteComp(at indexPath: IndexPath) {
        let comp = self.compList[indexPath.row]
        if let cId = comp.cbId {
            if let intCId = Int(cId) {
                self.compVM.deleteCompany(userMail: mail!, cbId: intCId)
                self.getComp()
            }
        }
    }
    
    func showDeleteWarningForBuy(for comp: String) {      //   TEST
        let alertController = UIAlertController(title: "Sildiğiniz firma 'Alım İşlemleri' listesinde de mevcut. Silinen firmanın bütün alım kayıtlarını silmek ister misiniz?", message: "Devam etmek için Tamam'a tıklayın.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
        alertController.addAction(cancelAction)
        let okeyAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
            // burada silme
            self.buyVM.deleteFromBuyWhenCompIsDeleted(userMail: self.mail!, compName: comp)
        }
        alertController.addAction(okeyAction)
        self.present(alertController, animated: true)
    }
    
    func companyBuyControl(at indexPath: IndexPath) {      //   TEST
        let comp = compList[indexPath.row]
        if let compName = comp.compName {
            buyVM.companyBuyControl(userMail: mail!, compName: compName) { buyCount in
                let count = buyCount.count
                print("Buy count geldi mi? \(count)")
                if count > 0 {
                    self.showDeleteWarningForBuy(for: compName)
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
        compVM.getAllCompany(userMail: mail!) { compData in
            self.compList = compData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
