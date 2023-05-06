//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit

//Получение данных
protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set } //Опциональное, чтобы при инициализации модели,не обязаны были setup значение
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    
    var numberOfCells: Int {
        articles.count
    }
    
    //MARK: -- Properties
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    private func loadData() {
        APIManager.getNews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles = self.convertToViewCellModel(articles)
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
    
    private func convertToViewCellModel(_ article: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return article.map { ArticleCellViewModel(article: $0) }
    }
    
    private func setupMockObject() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First", description: "First Description",
                                                                urlToImage: "...", date: "05.05.2023"))
        ]
    }
}
