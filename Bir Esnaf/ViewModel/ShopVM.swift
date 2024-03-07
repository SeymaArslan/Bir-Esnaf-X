//
//  ShopVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//

import Foundation

class ShopVM {
    func clearAllListInShop(userMail: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/clearAllListInShop.php")!)
        req.httpMethod = "POST"
        let postString = "userMail=\(userMail)"
        req.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error clear list in Shop")
                return
            }
            do {
                if let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(result)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getFirstSaleData(userMail: String, completion: @escaping([Shop]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getFirstSaleDataInShop.php")!)
        request.httpMethod = "POST"
        let string = "userMail=\(userMail)"
        request.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "getFirstSaleData error")
                return
            }
            do {
                let res = try JSONDecoder().decode(ShopData.self, from: data!)
                completion(res.shop ?? [Shop]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func sumAllSellProd(userMail: String, completion: @escaping([Shop]) -> ()) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/sumAllSellProd.php")!)
        req.httpMethod = "POST"
        let str = "userMail=\(userMail)"
        req.httpBody = str.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "sumAllSellProd error")
                return
            }
            do {
                let res = try JSONDecoder().decode(ShopData.self, from: data!)
                completion(res.shop ?? [Shop]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchShop(userMail: String, prodName: String, completion: @escaping([Shop]) -> () ) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/fetchShop.php")!)
        req.httpMethod = "POST"
        let string = "userMail=\(userMail)&prodName=\(prodName)"
        req.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, err in
            if err != nil {
                print(err?.localizedDescription ?? "fatchShop Error")
                return
            }
            do {
                let response = try JSONDecoder().decode(ShopData.self, from: data!)
                completion(response.shop ?? [Shop]())
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func pullSalesForPickerView(userMail: String, completion: @escaping([Shop]) -> () ) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/pullSalesForPickerView.php")!)
        request.httpMethod = "POST"
        let str = "userMail=\(userMail)"
        request.httpBody = str.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil {
                print(err?.localizedDescription ?? "pullSalesForPickerView error")
                return
            }
            do {
                let response = try JSONDecoder().decode(ShopData.self, from: data!)
                completion(response.shop ?? [Shop]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func addShop(userMail: String, prodName: String, totalProfitAmount: Double) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addShopping.php")!)
        req.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&totalProfitAmount=\(totalProfitAmount)"
        req.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "addShop error")
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
    
}
