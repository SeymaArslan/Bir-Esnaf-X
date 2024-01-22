//
//  CompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import UIKit

class CompanyTableViewController: UITableViewController {
    
    var compList = [CompanyBank]()
    let mail = userDefaults.string(forKey: "userMail")
    let compVM = CompanyVM()
    let bankVM = BankVM()
    var company: Company?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
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
        self.performSegue(withIdentifier: "goToCompDet", sender: indexPath.row)  // indexPath.row?
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAct = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.showDeleteWarning(for: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAct])
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
                self.compVM.deleteCompany(cbId: intCId)
                self.getComp()
            }
        }
    }
    
    
    func getComp() {
        compVM.getAllCompanies(userMail: mail!) { compData in
            self.compList = compData
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
    
}
