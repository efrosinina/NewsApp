//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit


final class GeneralViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        APIManager.getNews(from: .general, page: page, searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
