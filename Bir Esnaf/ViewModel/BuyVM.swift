//
//  BuyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import Foundation

class BuyVM {
    func deleteFromBuyWhenCompIsDeleted(userMail: String, compName: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteFromBuyWhenCompIsDeleted.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(userMail)&compName=\(compName)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, res, error in
            if error != nil {
                print(error?.localizedDescription ?? "Delete buy error")
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
    
    func companyBuyControl(userMail: String, compName: String, completion: @escaping([Buy]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/companyBuyControl.php")!)
        request.httpMethod = "POST"
        let string = "userMail=\(userMail)&compName=\(compName)"
        request.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "count sale error")
                return
            }
            do {
                let result = try JSONDecoder().decode(BuyData.self, from: data!)
                completion(result.buy ?? [Buy]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func countBuy(userMail: String, completion: @escaping([Buy]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/countBuy.php")!)
        request.httpMethod = "POST"
        let string = "userMail=\(userMail)"
        request.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "count sale error")
                return
            }
            do {
                let result = try JSONDecoder().decode(BuyData.self, from: data!)
                completion(result.buy ?? [Buy]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func deleteCell(userMail: String, buyId: Int) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteBuy.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(userMail)&buyId=\(buyId)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error delete buy cell")
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
    
    func updateBuy(userMail: String, buyId: Int, compName: String, productName: String, price: Double, total: Double, totalPrice: Double, buyDate: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/updateBuy.php")!)
        request.httpMethod = "POST"
        let post = "userMail=\(userMail)&buyId=\(buyId)&compName=\(compName)&productName=\(productName)&price=\(price)&total=\(total)&totalPrice=\(totalPrice)&buyDate=\(buyDate)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Update Buy Error")
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
    
    func getBuyList(userMail: String, completion: @escaping ([Buy]) -> () ) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getBuyList.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(userMail)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Get buy list error")
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(BuyData.self, from: data!)
                completion(jsonData.buy ?? [Buy]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchCompList(userMail: String, completion: @escaping ([CompanyBank]) -> () ){  // bunun web servisi düzenle
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/fetchCompListForBuy.php")!)
        req.httpMethod = "POST"
        let str = "userMail=\(userMail)"
        req.httpBody = str.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(CompanyBankData.self, from: data!)
                completion(jsonData.companyBank ?? [CompanyBank]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func addBuy(mail: String, compName: String, productName: String, price: Double, total: Double, totalPrice: Double, buyDate: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addBuy.php")!)
        request.httpMethod = "POST"
        let post = "userMail=\(mail)&compName=\(compName)&productName=\(productName)&price=\(price)&total=\(total)&totalPrice=\(totalPrice)&buyDate=\(buyDate)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error!)
//                print(error?.localizedDescription ?? "Buy insert error")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(json)
                }
            } catch {
//                print(error.localizedDescription)
                print(error)
            }
        }.resume()
    }
    
}
