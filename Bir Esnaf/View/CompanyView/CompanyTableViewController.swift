//
//  CompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import UIKit

class CompanyTableViewController: UITableViewController {
    
    var compList = [Company]()
    let mail = userDefaults.string(forKey: "userMail")
    let compVM = CompanyVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getComp()
    }
    

    @IBAction func goToCompAdd(_ sender: Any) {
    }
    
    //MARK: - Helpers
    func getComp() {
        compVM.compParse(userMail: mail!, comp: { compData in
            self.compList = compData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCompDet" {
            guard let indeks = sender as? Int else { return }
            let goToVC = segue.destination as! CompanyDetailTableViewController
            goToVC.company = compList[indeks]
        }
    }
    
    // MARK: - Table view data source
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

}


