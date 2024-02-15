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
    let userMail: String?
    let prodName: String?
    let salePrice: String?
    let saleTotal: String?
    let saleTotalPrice: String?
    let saleDate: String?
    let count: String?
}
