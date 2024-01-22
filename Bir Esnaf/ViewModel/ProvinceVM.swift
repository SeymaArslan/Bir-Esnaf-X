//
//  ProvinceVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.01.2024.
//

import Foundation

class ProvinceVM {
    
    func getSelectedProvince(province: String, completion: @escaping ([Province]) -> () ) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getSelectedProvince.php")!)
        request.httpMethod = "POST"
        let post = "province=\(province)"
        request.httpBody = post.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata")
                return
            }
            do {
                let result = try JSONDecoder().decode(ProvinceData.self, from: data!)
                completion(result.province ?? [Province]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getProvince(completion: @escaping ([Province]) -> () ) {
        let url = URL(string: "https://lionelo.tech/birEsnaf/getCity.php")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            do {
                let result = try JSONDecoder().decode(ProvinceData.self, from: data!)
                completion(result.province ?? [Province]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
}
