//
//  Sell.swift
//  Bir Esnaf
//
//  Created by Seyma on 28.01.2024.
//

import Foundation

class SaleData: Codable {
    let sale: [Sale]?
}

class Sale: Codable {
    let saleId: String?
    let prodName: String?
    let salePrice: String?
    let total: String?
    let totalPrice: String?
    let saleDate: String?
}
