//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 07/05/2023.
//

import UIKit

final class BusinessViewModel: NewsListViewModel {
    //MARK: -- Methods
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        APIManager.getNews(from: .business, page: page, searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
    
    override func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
}
