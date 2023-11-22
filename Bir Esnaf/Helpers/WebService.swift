//
//  WebService.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation

enum CompanyError: Error {
    case parsingError
    case serverError
}

class WebService {

    /*
     func downloadCompanies(url: URL, completion: @escaping (Result<[CompanyData], CompanyError>) -> () ) {
         URLSession.shared.dataTask(with: url) { data, response, error in
             if let _ = error {
                 completion(.failure(.serverError))
             } else if let data = data {
                 let compList = try? JSONDecoder().decode([CompanyData].self, from: data)
                 if let compList = compList {
                     completion(.success(compList))
                 } else {
                     completion(.failure(.parsingError))
                 }
             }
         }.resume()
     }
     
     */
    
//    func downloadCompanies(url: URL, completion: @escaping (Result<[Company], CompanyError>) -> () ) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(.failure(.serverError))
//            } else if let data = data {
//                let compList = try? JSONDecoder().decode(CompanyData.self, from: data)
//                if let compList = compList {
//                    completion(.success(compList.company ?? []))
//                } else {
//                    completion(.failure(.parsingError))
//                }
//            }
//        }.resume()
//    }
    


    
}
