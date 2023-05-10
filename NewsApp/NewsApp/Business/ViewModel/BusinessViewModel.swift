//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 07/05/2023.
//

import UIKit
//MARK: -- Protocol
protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModelBusiness
}

class BusinessViewModel: BusinessViewModelProtocol {
    //MARK: -- Closures
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    //MARK: -- Properties
    var numberOfCells: Int {
        articles.count
    }
    
    private var articles: [ArticleCellViewModelBusiness] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    //MARK: -- Initialization
    init() {
        loadData()
    }
    
    //MARK: -- Methods
    func getArticle(for row: Int) -> ArticleCellViewModelBusiness {
        return articles[row]
    }
    
    //MARK: -- Private Methods
    private func loadData() {
        
            APIManager.getBusinessNews { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let articles):
                    self.articles = self.convertToCellViewModel(articles)
                    self.loadImage()
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showError?(error.localizedDescription)
                    }
                }
            }
        }
    
    private func loadImage() {
        for (index, article) in articles.enumerated() {
            APIManager.getImageData(url: article.imageUrl) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articles: [BusinessArticleResponseObject]) -> [ArticleCellViewModelBusiness] {
        return articles.map { ArticleCellViewModelBusiness(article: $0) }
    }
    
    private func setupMockObject() {
        articles = [
            ArticleCellViewModelBusiness(article: BusinessArticleResponseObject(title: "first", description: "first description", urlToImage: "dsdsd", date: "23.04.2023"))
        ]
    }
}
