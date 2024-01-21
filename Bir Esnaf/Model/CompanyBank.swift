//
//  CompanyBank.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.01.2024.
//

import Foundation

class CompanyBankData: Codable {
    let companyBank: [CompanyBank]?
}

class CompanyBank: Codable {
    let cbId: String?
    let userMail: String?
    let compName: String?
    let compPhone: String?
    let compMail: String?
    let province: String? // il
    let district: String? // ilce
    let quarter: String? // mahalle
    let asbn: String? // avenue/street/building/number
    let bankName: String?
    let bankBranchName: String?
    let bankBranchCode: String?
    let bankAccountType: String?
    let bankAccountName: String?
    let bankAccountNum: String?
    let bankIban: String?
}
