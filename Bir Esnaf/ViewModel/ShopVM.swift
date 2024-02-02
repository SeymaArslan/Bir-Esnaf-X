//
//  ShopVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//

import Foundation

class ShopVM {
    
    
    func addShop(userMail: String, prodName: String, shopPriceDifference: Double, shopTotalDifference: Double) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addShopping.php")!)
        req.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&shopPriceDifference=\(shopPriceDifference)&shopTotalDifference=\(shopTotalDifference)"
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


/**
 
 profitAmount fiyat farkı buradan ve totalDiff ile çarparak fiyat farkı yazılacak shoppingViewCont ta
 buradaki prodName e göre totalDiff miktarı prod tablosundaki totalden düşecek ama düştükten sonra total 0 olmalı tekrar tekrar düşmemesi için
 yani total miktarından düştükten sonra totalDiff kendi rakamı kadar düşüş yaşamalı veya kişi satışı silerse yaşamamalı o zaman düşmeyecek..
 
 peki hep düşer mi en iyisi denemek..
 
 
 */
