//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 13/05/2023.
//

import UIKit

final class TechnologyViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        APIManager.getNews(from: .technology, page: page, searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
