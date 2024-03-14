//
//  SaleVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 29.01.2024.
//

import Foundation

class SaleVM {
    func deleteFromSaleWhenProductsIsDeleted(userMail: String, prodName: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteFromSaleWhenProductIsDeleted.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(userMail)&prodName=\(prodName)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, res, error in
            if error != nil {
                print(error?.localizedDescription ?? "Delete sale error")
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
    
    func productSaleControl(userMail: String, prodName: String, completion: @escaping([Sale]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/productSalesControl.php")!)
        request.httpMethod = "POST"
        let string = "userMail=\(userMail)&prodName=\(prodName)"
        request.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "count sale error")
                return
            }
            do {
                let result = try JSONDecoder().decode(SaleData.self, from: data!)
                completion(result.sale ?? [Sale]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getFirstSaleInCompany(userMail: String, completion: @escaping([Product]) -> ()) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getFirstSaleDataInShop.php")!)
        req.httpMethod = "POST"
        let strPost = "userMail=\(userMail)"
        req.httpBody = strPost.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "getFirstSaleInCompany error")
                return
            }
            do {
                let res = try JSONDecoder().decode(ProductData.self, from: data!)
                completion(res.product ?? [Product]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func oldSaleUpdate(userMail: String, prodName: String, prodTotal: Double) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/oldSaleUpdate.php")!)
        req.httpMethod = "POST"
        let strPost = "userMail=\(userMail)&prodName=\(prodName)&prodTotal=\(prodTotal)"
        req.httpBody = strPost.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                    print(json)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func countSale(userMail: String, completion: @escaping([Sale]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/countSale.php")!)
        request.httpMethod = "POST"
        let string = "userMail=\(userMail)"
        request.httpBody = string.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "count sale error")
                return
            }
            do {
                let result = try JSONDecoder().decode(SaleData.self, from: data!)
                completion(result.sale ?? [Sale]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func deleteSale(userMail: String, saleId: Int) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteSale.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(userMail)&saleId=\(saleId)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, res, error in
            if error != nil {
                print(error?.localizedDescription ?? "Delete sale error")
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
    
    func updateSale(userMail: String, saleId: Int, prodName: String, salePrice: Double, saleTotal: Double, saleTotalPrice: Double, saleDate: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/updateSale.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(userMail)&saleId=\(saleId)&prodName=\(prodName)&salePrice=\(salePrice)&saleTotal=\(saleTotal)&saleTotalPrice=\(saleTotalPrice)&saleDate=\(saleDate)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Sale Update error")
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
    
    func getSaleList(mail: String, completion: @escaping ([Sale]) -> () ) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/saleList.php")!)
        request.httpMethod = "POST"
        let post = "userMail=\(mail)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "get sale list error")
                return
            }
            do {
                let response = try JSONDecoder().decode(SaleData.self, from: data!)
                completion(response.sale ?? [Sale]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func addSale(mail: String, prodName: String, salePrice: Double, saleTotal: Double, saleTotalPrice: Double, saleDate: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addSale.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(mail)&prodName=\(prodName)&salePrice=\(salePrice)&saleTotal=\(saleTotal)&saleTotalPrice=\(saleTotalPrice)&saleDate=\(saleDate)"
        req.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Sale insert error")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]{
                    print(json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchProdList(comp: @escaping([Product]) -> ()) {
        let url = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/fetchProdListForSale.php")!)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let result = try JSONDecoder().decode(ProductData.self, from: data!)
                comp(result.product ?? [Product]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

