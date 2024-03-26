//
//  UserVM.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.11.2023.
//

import Foundation

class UserVM {
    func deleteAllData(userMail: String) {
        var req = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/deleteAllDataWithUser.php")!)
        req.httpMethod = "POST"
        let postStr = "userMail=\(userMail)"
        req.httpBody = postStr.data(using: .utf8)
        URLSession.shared.dataTask(with: req) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Delete all data error")
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
    
    func userAdd(userMail: String) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/insertUser.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, respone, error in
            if error != nil || data == nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                if let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(result) // get message
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func userControl(userMail: String, completion: @escaping ([UserMysql]) -> ()) {
        var request = URLRequest(url: URL(string: "https://lionelo.tech/birEsnaf/selectUser.php")!)
        request.httpMethod = "POST"
        let postString = "userMail=\(userMail)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, respone, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let result = try JSONDecoder().decode(UserData.self, from: data!)
                completion(result.user ?? [])
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
}
