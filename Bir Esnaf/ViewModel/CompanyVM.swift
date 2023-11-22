//
//  CompanyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation

class CompanyVM {
    
    func compParse(comp: @escaping ([Company]) -> ()) {
        let api = URL(string: "https://lionelo.tech/birEsnaf/allCompanies.php")!
        URLSession.shared.dataTask(with: api) { data, response, error in
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
    
    func compUpdate(compId: String, compName: String, compAddress: String, compPhone: String, compMail: String, comp: @escaping ([Company]) -> ()) {
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


/*
 var compList: [Company] = []
 let error: String = ""
 
 func requestData() {
     let url = URL(string: "https://lionelo.tech/birEsnaf/allCompanies.php")!
     WebService().downloadCompanies(url: url) { result in
         switch result {
         case .success(let list):
             self.compList = list
         case .failure(let error):
             switch error {
             case .parsingError:
                 print(error.localizedDescription ?? "")
             case .serverError:
                 print(error.localizedDescription ?? "")
             }
         }
     }
 }
 */
