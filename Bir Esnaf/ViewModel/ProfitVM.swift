//
//  ProfitVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 2.02.2024.
//

import Foundation

class ProfitVM {
    
    func getProfit(userMail: String, prodName: String, completion: @escaping([Profit]) -> ()) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/getProfit.php")!)
        req.httpMethod = "POST"
        let postStr = "userMail=\(userMail)&prodName=\(prodName)"
        req.httpBody = postStr.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, res, err in
            if err != nil {
                print(err?.localizedDescription ?? "getProfit error")
                return
            }
            do {
                let response = try JSONDecoder().decode(ProfitData.self, from: data!)
                completion(response.profit ?? [Profit]())
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func addProfit(userMail: String, prodName: String, profitAmount: Double) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/addProfit.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)&prodName=\(prodName)&profitAmount=\(profitAmount)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "addProfit error")
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
