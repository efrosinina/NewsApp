//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 12/05/2023.
//

import UIKit
//MARK: -- Protocol
protocol NewsListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func loadData(searchText: String?)
}

class NewsListViewModel: NewsListViewModelProtocol {
    //MARK: -- Closures
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    //MARK: -- Properties
    var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    var page: Int = 0
    var searchText: String? = nil
    private var isSearchTextChanged: Bool = false
    
    //MARK: -- Methods
    func loadData(searchText: String? = nil) {
        if self.searchText != searchText {
            page = 1
            isSearchTextChanged = true
        } else {
            page += 1
            isSearchTextChanged = false
        }
        self.searchText = searchText
    }
    
    func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        let viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty || isSearchTextChanged {
            let firstSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection]
        } else {
            sections[0].items += viewModels
        }
    }
    
    func handleResult(_ result: Result<[ArticleResponseObject], Error>) {
        switch result {
        case .success(let articles):
            self.convertToCellViewModel(articles)
            self.loadImage()
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    //MARK: -- Private Methods
    private func loadImage() {
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                guard let article = item as? ArticleCellViewModel else { return }
                let url = article.imageUrl
                APIManager.getImageData(url: url) { [weak self] result in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                article.imageData = data
                            }
                            self?.reloadCell?(IndexPath(row: index, section: i))
                        case .failure(let error):
                            self?.showError?(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    private func setupMockObject() {
        sections = [
            TableCollectionViewSection(items: [ArticleCellViewModel(article: ArticleResponseObject(title: "first",
                                                                                                   description: "first description", urlToImage: "dsdsd",
                                                                                                   date: "23.04.2023"))])
        ]
    }
}
