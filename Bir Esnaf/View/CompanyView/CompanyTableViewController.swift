//
//  CompanyTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import UIKit

class CompanyTableViewController: UITableViewController {

    var compList = [Company]()
    let compVM = CompanyVM()
    var userId: UserMysql?
    let userVM = UserVM()
    var userMysql = [UserMysql]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        userVM.getUserId(userMail: compUserMail?.email ?? "") { userMysqlData in
//            self.userMysql = userMysqlData
//        }
  
//        userVM.getUserId(userMail: compUserMail?.userMail ?? "") { usermysqlData in
//            self.userMysql = usermysqlData
//        }  // buradaki userMysql listesinde id yi çekeceğiz ki liste dönmüyor tek veri geliyor gerçi 
        
//        compVM.compParse(userId: userMysql[0].userId ?? "") { data in
//            self.compList = data
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    @IBAction func goToCompAdd(_ sender: Any) {
        performSegue(withIdentifier: "goToCompAdd", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let indeks = sender as? Int
//        let goToVC = segue.destination as! CompanyDetailTableViewController
//        goToVC.company = compList[indeks!]
        
        if(segue.identifier == "goToCompAdd") {
            let addComp = segue.destination as! AddCompanyTableViewController
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
        performSegue(withIdentifier: "goToCompDet", sender: indexPath.row)
       
    }
    
    
}


