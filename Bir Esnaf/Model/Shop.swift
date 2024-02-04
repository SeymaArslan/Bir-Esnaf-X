//
//  Shop.swift
//  Bir Esnaf
//
//  Created by Seyma on 1.02.2024.
//

import Foundation

class ShopData: Codable {
    let shop: [Shop]?
}

class Shop: Codable {
    let shopId: String?
    let userMail: String?
    let prodName: String?
    let totalProfitAmount: String?
}
