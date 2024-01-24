//
//  BuyVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import Foundation

class BuyVM {
    
    func addBuy(mail: String, compName: String, price: Float, total: Float, totalPrice: Float, buyDate: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addBuy.php")!)
        request.httpMethod = "POST"
        let post = "userMail=\(mail)&compName=\(compName)&price=\(price)&total=\(total)&totalPrice=\(totalPrice)&buyDate=\(buyDate)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Buy insert error")
                return
            }
            do {
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
