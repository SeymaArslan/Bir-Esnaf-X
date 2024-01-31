//
//  ProductVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 22.01.2024.
//

import Foundation

class ProductVM {
    
    func getSelectedProdPicker(prodName: String, completion: @escaping ([Product]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getSelectedProdPicker.php")!)
        request.httpMethod = "POST"
        let post = "prodName=\(prodName)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error get selected product in updateSale")
                return
            }
            do {
                let result = try JSONDecoder().decode(ProductData.self, from: data!)
                completion(result.product ?? [Product]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func deleteProd(prodId: Int) {
        var api = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteProduct.php")!)
        api.httpMethod = "POST"
        let postStr = "prodId=\(prodId)"
        api.httpBody = postStr.data(using: .utf8)
        URLSession.shared.dataTask(with: api) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Delete Error")
                return
            }
            do {
                if let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    print(result)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func updateProd(prodId: Int, prodName: String, prodTotal: Int, prodPrice: Double) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/updateProduct.php")!)
        request.httpMethod = "POST"
        let post = "prodId=\(prodId)&prodName=\(prodName)&prodTotal=\(prodTotal)&prodPrice=\(prodPrice)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Update Error")
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

    func getAllProd(userMail: String, completion: @escaping ([Product]) -> () ) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getAllProduct.php")!)
        request.httpMethod = "POST"
        let post = "userMail=\(userMail)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata")
                return
            }
            do {
                let result = try JSONDecoder().decode(ProductData.self, from: data!)
                completion(result.product ?? [Product]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func insertProd(userMail: String, prodName: String, prodTotal: Int, prodPrice: Double) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addProduct.php")!)
        request.httpMethod = "POST"
        let post = "userMail=\(userMail)&prodName=\(prodName)&prodTotal=\(prodTotal)&prodPrice=\(prodPrice)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "" )
                return
            } 
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                    print(json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
