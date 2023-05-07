//
//  BusinessNewsResponceObject.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 07/05/2023.
//

import UIKit

struct BusinessNewsResponseObject: Codable {
    let totalResults: Int
    let articles: [BusinessArticleResponseObject]
    
    enum CodingKeys: CodingKey { // Название case будет соостветсвовать названию ключа JSON-объекта
        case totalResults
        case articles
    }
}
