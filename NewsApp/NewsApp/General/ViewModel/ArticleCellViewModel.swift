//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit

final class ArticleCellViewModel: TableCollectionViewItemsProtocol {
    //MARK: -- Properties
    let title: String
    let description: String
    let imageUrl: String?
    var date: String
    var imageData: Data?
    
    //MARK: -- Initialization
    init(article: ArticleResponseObject) {
        title = article.title ?? ""
        description = article.description ?? ""
        date = article.date
        imageUrl = article.urlToImage ?? ""
        
        if let formatDate = formatDate(dateString: date) {
            self.date = formatDate
        }
    }
    
    //MARK: -- Private Methods
    private func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
