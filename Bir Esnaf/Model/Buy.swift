//
//  Buy.swift
//  Bir Esnaf
//
//  Created by Seyma on 24.01.2024.
//

import Foundation

class BuyData: Codable {
    let buy: [Buy]?
}

class Buy: Codable {
    let buyId: String
    let userMail: String
    let compName: String
    let price: String
    let total: String
    let totalPrice: String
    let buyDate: String
}
