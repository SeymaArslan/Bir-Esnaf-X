//
//  Bank.swift
//  Bir Esnaf
//
//  Created by Seyma on 22.11.2023.
//

import Foundation

class BankData: Codable {
    let bank: [Bank]?
}

class Bank: Codable {
    let bankId: String?
    let compId: String?
    let bankName: String?
    let bankBranchName: String?
    let bankBranchCode: String?
    let bankAccountType: String?
    let bankAccountName: String?
    let bankAccountNum: String?
    let bankIban: String?
}
