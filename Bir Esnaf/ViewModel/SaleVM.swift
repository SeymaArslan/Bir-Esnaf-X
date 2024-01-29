//
//  SaleVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 29.01.2024.
//

import Foundation

class SaleVM {
    func addSale() {
        
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
