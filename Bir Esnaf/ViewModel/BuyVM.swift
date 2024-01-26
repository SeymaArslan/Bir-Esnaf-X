//
//  BuyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import Foundation

class BuyVM {
    
    func updateBuy(buyId: Int, compName: String, productName: String, price: Double, total: Double, totalPrice: Double, buyDate: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/updateBuy.php")!)
        request.httpMethod = "POST"
        let post = "buyId=\(buyId)&compName=\(compName)&productName=\(productName)&price=\(price)&total=\(total)&totalPrice=\(totalPrice)&buyDate=\(buyDate)"
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
    
    func fetchCompList(completion: @escaping ([CompanyBank]) -> () ){
        let url = URL(string: "https://lionelo.tech/birEsnaf/fetchCompListForBuy.php")!
        URLSession.shared.dataTask(with: url) { data, response, error in
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
                print(error?.localizedDescription ?? "Buy insert error")
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
