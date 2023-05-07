//
//  ArticleCellViewModelBusiness.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 07/05/2023.
//

import UIKit

struct ArticleCellViewModelBusiness {
    let title: String
    let description: String
    let date: String
    let imageUrl: String
    var imageData: Data?
    
    init(article: BusinessArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.date
        imageUrl = article.urlToImage
    }
}


