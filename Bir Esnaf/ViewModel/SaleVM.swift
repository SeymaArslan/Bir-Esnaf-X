//
//  SaleVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 29.01.2024.
//

import Foundation

class SaleVM {
    
    func addSale(mail: String, prodName: String, salePrice: Double, total: Double, totalPrice: Double, saleDate: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addSale.php")!)
        req.httpMethod = "POST"
        let post = "userMail=\(mail)&prodName=\(prodName)&salePrice=\(salePrice)&total=\(total)&totalPrice=\(totalPrice)&saleDate=\(saleDate)"
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

