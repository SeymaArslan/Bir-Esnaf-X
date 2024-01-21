//
//  Province.swift
//  Bir Esnaf
//
//  Created by Seyma on 17.01.2024.
//

import Foundation

class ProvinceData: Codable {
    let province: [Province]?
}

class Province: Codable {
    let pId: String?
    let province: String?
}
