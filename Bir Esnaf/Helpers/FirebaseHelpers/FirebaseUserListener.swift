//
//  FirebaseUserListener.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class FirebaseUserListener {
    static let shared = FirebaseUserListener()
    let userVM = UserVM()
    
    private init() {  }
    
    //MARK: - Login
    func loginUserWithEmail(email: String, password: String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            
            if error == nil && authDataResult!.user.isEmailVerified {
                FirebaseUserListener.shared.downloadUserFromFirebase(userId: authDataResult!.user.uid, email: email)
                completion(error, true)
            } else {
                print("email is not verified")
                completion(error, false)
            }
        }
    }
    
    //MARK: - Register
    func registerUserWith(email: String, password: String, completion: @escaping(_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
            if error == nil {
                authResult!.user.sendEmailVerification { error in  // send verification email
                    print("Auth email send with error: ", error?.localizedDescription as Any)
                }
                
                // create user and save it
                if authResult?.user != nil {
                    let user = User(id: authResult!.user.uid, email: email)
                    saveUserLocally(user)
                    self.saveUserToFirestore(user)
                    saveUserMailLocally(user.email)
                }
            }
        }
        
        userVM.userAdd(userMail: email)
        
    }
    
    //MARK: - Resend Link Methods
    func resendVerificationEmail(email: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completion(error)
            })
        })
    }
    
    func resetPasswordFor(email: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    //MARK: - Log Out
    func logOutCurrentUser(completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            
            userDefaults.removeObject(forKey: kcurrentUser)
            userDefaults.synchronize() // nesnemizi kaldırdıktan sonra senkronize ederek güvenliğini sağlamak istiyoruz.
            
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
    
    //MARK: - Delete Account
    func deleteAccountCurrentUser(completion: @escaping(_ error: Error?) -> Void) {
        Auth.auth().currentUser?.delete { error in  // bu func 2
            if let error = error {
                // hata atarsa
                completion(error)
            } else {
                // hesap silindi
                userDefaults.removeObject(forKey: kcurrentUser)
                userDefaults.synchronize()
                completion(nil)
            }
        }
    }
    
    //MARK: - Save Users
    func saveUserToFirestore(_ user: User) {
        do {
            try FirebaseReference(.User).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription, "adding user")
        }
    }
    
    
    //MARK: - Download User From Firebase
    func downloadUserFromFirebase(userId: String, email: String? = nil) {
        FirebaseReference(.User).document(userId).getDocument { querySnapshot, error in
            guard let document = querySnapshot else {
                print("No document for user")
                return
            }
            let result = Result {
                try? document.data(as: User.self) // kullanıcı nesnesi oluşturmaya çalış dedik.
            }
            switch result {
            case .success(let userObject):
                if let user = userObject {
                    saveUserLocally(user)
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding user ", error)
            }
        }
    }
    
}
