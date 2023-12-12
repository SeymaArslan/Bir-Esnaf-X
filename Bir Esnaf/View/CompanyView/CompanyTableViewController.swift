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
        
        getComp()
    }
    

    @IBAction func goToCompAdd(_ sender: Any) {
//        let deneme = "---- oldu mu? -----"
        performSegue(withIdentifier: "goToCompAdd", sender: self)
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
//        let indeks = sender as? Int
//        let goToVC = segue.destination as! CompanyDetailTableViewController
//        goToVC.company = compList[indeks!]
        
        if(segue.identifier == "goToCompDet") {
            print("geçiş olduuuuuu mu ")  // olmadı :/
            //let addComp = segue.destination as! AddCompanyTableViewController
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
//        if let url = URL(string: "https://lionelo.tech/birEsnafImages/\(comp.compLogoURL ?? "default.png")") {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    cell.companyLogo.image = UIImage(data: data!)
//                }
//            }
//        }

        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // performSegue(withIdentifier: "goToCompDet", sender: indexPath.row)
        print("bastımmmmmm")
       
    }

    
}


