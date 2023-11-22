//
//  Company.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.11.2023.
//

import Foundation

class CompanyData: Codable {
    let company: [Company]?
}

class Company: Codable {
    let compId: String?
    let userId: String?
    let bankId: String?
    let compName: String?
    let compLogoURL: String?
    let compAddress: String?
    let compPhone: String?
    let compMail: String?
}
