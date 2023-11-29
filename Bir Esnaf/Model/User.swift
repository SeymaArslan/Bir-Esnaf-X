//
//  User.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//  3 numara 3. dk firebase database a tablo olarak kayıt yapmıyor en iyisi yeni baştan kur?

import Foundation
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseAuth

struct User: Codable, Equatable {
    var id = ""
//    var userName: String
    var email: String
    
    static var currentId: String {
        return Auth.auth().currentUser!.uid
    }
    
    static var currentUser: User? {
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.data(forKey: kcurrentUser) {
                let decoder = JSONDecoder()
                do {
                    let userObject = try decoder.decode(User.self, from: dictionary)
                    return userObject
                } catch {
                    print("Error decoding user from user defaults ", error.localizedDescription)
                }
            }
        }
        return nil
    }

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

func saveUserLocally(_ user: User) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(user)
        UserDefaults.standard.set(data, forKey: kcurrentUser)
    } catch {
        print("error saving user locally ", error.localizedDescription)
    }
}

struct UserData: Codable {
    let user: [UserMysql]?
}

struct UserMysql: Codable {
    var userId: String?
    var userMail: String?
}
