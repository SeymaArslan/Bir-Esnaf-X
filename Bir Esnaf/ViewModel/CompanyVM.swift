//
//  CompanyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation

class CompanyVM {
    
    func countCompBank(userMail: String, completion: @escaping([CompanyBank]) -> ()) { 
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/countCompBank.php")!)
        req.httpMethod = "POST"
        let string = "userMail=\(userMail)"
        req.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "count company error")
                return
            }
            do {
                let result = try JSONDecoder().decode(CompanyBankData.self, from: data!)
                completion(result.companyBank ?? [CompanyBank]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getSelectedCompPicker(compName: String, completion: @escaping ([CompanyBank]) -> () ) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getSelectedCompPicker.php")!)
        req.httpMethod = "POST"
        let post = "compName=\(compName)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Get selected company picker error")
                return
            }
            do {
                let result = try JSONDecoder().decode(CompanyBankData.self, from: data!)
                completion(result.companyBank ?? [CompanyBank]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func compUpdate(userMail: String, cbId: Int, compName: String, compPhone: String, compMail: String, province: String, district: String, quarter: String, asbn: String, bankName: String, bankBranchName: String, bankBranchCode: String, bankAccountType: String, bankAccountName: String, bankAccountNum: Int, bankIban: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/updateComp.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&cbId=\(cbId)&compName=\(compName)&compPhone=\(compPhone)&compMail=\(compMail)&province=\(province)&district=\(district)&quarter=\(quarter)&asbn=\(asbn)&bankName=\(bankName)&bankBranchName=\(bankBranchName)&bankBranchCode=\(bankBranchCode)&bankAccountType=\(bankAccountType)&bankAccountName=\(bankAccountName)&bankAccountNum=\(bankAccountNum)&bankIban=\(bankIban)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    print(json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func deleteCompany(userMail: String, cbId: Int) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteComp.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&cbId=\(cbId)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, respone, error in
            if error != nil || data == nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                if let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(result) // get message
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getAllCompany(userMail: String, comp: @escaping([CompanyBank]) -> ()) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/companyListWithUser.php")!)
        req.httpMethod = "POST"
        let str = "userMail=\(userMail)"
        req.httpBody = str.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, res, error in
            if error != nil {
                print(error?.localizedDescription ?? "get all company error")
                return
            }
            do {
                let result = try JSONDecoder().decode(CompanyBankData.self, from: data!)
                comp(result.companyBank ?? [CompanyBank]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func companyInsert(userMail: String, compName: String, compPhone: String, compMail: String, province: String, district: String, quarter: String, asbn: String, bankName: String, bankBranchName: String, bankBranchCode: String, bankAccountType: String, bankAccountName: String, bankAccountNum: Int, bankIban: String) {
        var api = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/insertCompany.php")!)
        api.httpMethod = "POST"
        let postString = "userMail=\(userMail)&compName=\(compName)&compPhone=\(compPhone)&compMail=\(compMail)&province=\(province)&district=\(district)&quarter=\(quarter)&asbn=\(asbn)&bankName=\(bankName)&bankBranchName=\(bankBranchName)&bankBranchCode=\(bankBranchCode)&bankAccountType=\(bankAccountType)&bankAccountName=\(bankAccountName)&bankAccountNum=\(bankAccountNum)&bankIban=\(bankIban)"
        api.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: api) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    print(json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    

}


