//
//  CompanyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation

class CompanyVM {
    
    let compList = [Company]()
    
    func compInsert(userId: String, compName: String, compLogoURL: String, compAddress: String, compPhone: String, compMail: String ) {
        var api = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/insertComp.php")!)
        api.httpMethod = "POST"
        let postString = "userId=\(userId)&compName=\(compName)&compLogoURL=\(compLogoURL)&compAddress=\(compAddress)&compPhone=\(compPhone)&compMail=\(compMail)"
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
    
    
    func compParse(userId: String, comp: @escaping ([Company]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/allCompanies.php")!)
        request.httpMethod = "POST"
        let postString = "userId=\(userId)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
               let result = try JSONDecoder().decode(CompanyData.self, from: data!)
                comp(result.company ?? [])
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func compUpdate(compId: String, compName: String, compAddress: String, compPhone: String, compMail: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/compUpdate.php")!)
        request.httpMethod = "POST"
        let postString = "compId=\(compId)&compName=\(compName)&compAddress=\(compAddress)&compPhone=\(compPhone)&compMail=\(compMail)"
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
    
    func bankParse(compId: String, comp: @escaping ([Bank]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/compDetailBank.php")!)
        request.httpMethod = "POST"
        let postString = "compId=\(compId)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, respone, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let result = try JSONDecoder().decode(BankData.self, from: data!)
                comp(result.bank ?? [])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func bankUpdate(bankId: String, bankName: String, bankBranchName: String, bankBranchCode: String, bankAccountType: String, bankAccountName: String, bankAccountNum: String, bankIban:String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/compBankUpdate.php")!)
        request.httpMethod = "POST"
        let postString = "bankId=\(bankId)&bankName=\(bankName)&bankBranchName=\(bankBranchName)&bankBranchCode=\(bankBranchCode)&bankAccountType=\(bankAccountType)%bankAccountName=\(bankAccountName)&bankAccountNum=\(bankAccountNum)&bankIban=\(bankIban)"
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
    

}


