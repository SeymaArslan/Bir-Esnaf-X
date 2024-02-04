//
//  Profit.swift
//  Bir Esnaf
//
//  Created by Seyma on 2.02.2024.
//

import Foundation

class ProfitData: Codable {
    let profit: [Profit]?
}

class Profit: Codable {
    let profId: String?
    let userMail: String?
    let prodName: String?
    let profitAmount: String?
}
