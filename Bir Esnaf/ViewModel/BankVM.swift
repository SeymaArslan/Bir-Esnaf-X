//
//  BankVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 12.12.2023.
//

import Foundation

class BankVM {
    func bankInsert(uMAil: String, cId: Int, bName: String, bBranchName: String, bBranchCode: String, bAccType: String, bAccName: String, bAccNum: String, bIban: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/insertBank.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(uMAil)&compId=\(cId)&bankName=\(bName)&bankBranchName=\(bBranchName)&bankBranchCode=\(bBranchCode)&bankAccountType=\(bAccType)&bankAccountName=\(bAccName)&bankAccountNum=\(bAccNum)&bankIban=\(bIban)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func bankUpdate(bankId: String, bankName: String, bankBranchName: String, bankBranchCode: String, bankAccountType: String, bankAccountName: String, bankAccountNum: String, bankIban:String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/compBankUpdate.php")!)
        request.httpMethod = "POST"
        let postString = "bankId=\(bankId)&bankName=\(bankName)&bankBranchName=\(bankBranchName)&bankBranchCode=\(bankBranchCode)&bankAccountType=\(bankAccountType)&bankAccountName=\(bankAccountName)&bankAccountNum=\(bankAccountNum)&bankIban=\(bankIban)"
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
    
    func bankParse(bankId: Int, comp: @escaping ([Bank]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/compDetailBank.php")!)
        request.httpMethod = "POST"
        let postString = "bankId=\(bankId)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, respone, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let result = try JSONDecoder().decode(BankData.self, from: data!)
                comp(result.bank ?? [Bank]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
