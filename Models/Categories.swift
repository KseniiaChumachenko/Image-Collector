//
//  Categories.swift
//  5.JSON_handler
//
//  Created by iosdev on 1.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import Foundation

struct Categories: Decodable {
    let count: Int
    let categories: [Category]
}
struct Category: Decodable {
    let name: String
    let _id : String
}

struct Images: Decodable{
    let imagePosts: [Posts]
}
struct Posts: Decodable {
    let _id: String
    let image: String
    let category: String
}
