//
//  NewsResponseObject.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey { // Название case будет соостветсвовать названию ключа JSON-объекта
        case totalResults
        case articles
    }
}
