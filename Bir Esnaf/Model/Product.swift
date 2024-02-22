//
//  Product.swift
//  Bir Esnaf
//
//  Created by Seyma on 9.01.2024.
//

import Foundation

class ProductData: Codable {
    let product: [Product]?
}

class Product: Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.prodName == rhs.prodName
    }
    
    let prodId: String?
    let userMail: String?
    let prodName: String?
    let prodTotal: String?
    let prodPrice: String?
    let count: String?
}
