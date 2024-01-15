//
//  CompanyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation

class CompanyVM {
    
    func deleteComp(compId: Int) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteCompany.php")!)
        request.httpMethod = "POST"
        let postString = "compId=\(compId)"
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

    
    func updateBankId(compId: Int, bankId: Int) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/updateCompBankId.php")!)
        request.httpMethod = "POST"
        let postString = "compId=\(compId)&bankId=\(bankId)"
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

    
    func getLastCompId(comp: @escaping ([Company]) -> ()) {
        let api = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getCompId.php")!)
        URLSession.shared.dataTask(with: api) { data, response, error in
            if error != nil || data == nil {
                if let err = error?.localizedDescription {
                    print(err)
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(CompanyData.self, from: data!)
                if let getId = result.company {
                    comp(getId)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    
    func compInsert(userMail: String, compName: String, compAddress: String, compPhone: String, compMail: String ) {
        var api = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/insertComp.php")!)
        api.httpMethod = "POST"
        let postString = "userMail=\(userMail)&compName=\(compName)&compAddress=\(compAddress)&compPhone=\(compPhone)&compMail=\(compMail)"
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
    
    
    func compParse(userMail: String, comp: @escaping ([Company]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/allCompaniesWithUser.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
               let result = try JSONDecoder().decode(CompanyData.self, from: data!)
                comp(result.company ?? [Company]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func compUpdate(compId: Int, compName: String, compAddress: String, compPhone: String, compMail: String) {
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
    
}


