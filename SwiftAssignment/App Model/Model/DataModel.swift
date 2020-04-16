//
//  DataModel.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation

// MARK: - Model
struct DataModel: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Model Item
struct Row: Codable {
    let title, rowDescription: String?
    let imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
