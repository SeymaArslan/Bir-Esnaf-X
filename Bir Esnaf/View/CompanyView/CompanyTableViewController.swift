//
//  CompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//   https://srv972-files.hstgr.io/47340aed6050cf16/files/public_html/birEsnafImages/

import UIKit

class CompanyTableViewController: UITableViewController {

    var compList = [Company]()
    let compVM = CompanyVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        compVM.compParse { data in
            self.compList = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let goToVC = segue.destination as! CompanyDetailTableViewController
        goToVC.company = compList[indeks!]
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comp = compList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompanyTableViewCell
        cell.companyNameLabel.text = comp.compName
       // cell.companyLogo.image = UIImage(named: comp.compLogoURL!)
        if let url = URL(string: "https://lionelo.tech/birEsnafImages/\(comp.compLogoURL ?? "default.png")") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.companyLogo.image = UIImage(data: data!)
                }
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToCompDet", sender: indexPath.row)
    }
    
}


