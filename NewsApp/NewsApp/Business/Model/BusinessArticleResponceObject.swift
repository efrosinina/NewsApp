//
//  BusinessArticleResponceObject.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 07/05/2023.
//

import UIKit

struct BusinessArticleResponseObject: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt"
    }
}
