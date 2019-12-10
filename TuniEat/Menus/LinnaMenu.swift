//
//  LinnaMenu.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import Foundation

//let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - MenuRoot
struct LinnaMenu: Codable {
    let meta: Meta
    let courses: [String: Course]
}

// MARK: - Course
struct Course: Codable {
    let titleFi, titleEn, category, properties: String
    let price: String

    enum CodingKeys: String, CodingKey {
        case titleFi = "title_fi"
        case titleEn = "title_en"
        case category, properties, price
    }
}

// MARK: - Meta
struct Meta: Codable {
    let generatedTimestamp: Int
    let refURL, refTitle: String

    enum CodingKeys: String, CodingKey {
        case generatedTimestamp = "generated_timestamp"
        case refURL = "ref_url"
        case refTitle = "ref_title"
    }
}
