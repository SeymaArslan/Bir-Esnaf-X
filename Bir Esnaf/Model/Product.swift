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

class Product: Codable {
    let prodId: String?
    let prodName: String?
    let prodTotal: String?
    let prodPrice: String?
}
