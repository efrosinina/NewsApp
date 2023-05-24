//
//  APIManager.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit

final class APIManager {
    enum Category: String {
        case general = "general"
        case business = "business"
        case technology = "technology"
    }
    //MARK: -- Properties
    private static let apiKey = "c200d5fceabf4c948e525470c3ef3cc2"
    private static let basedUrl = "https://newsapi.org/v2/"
    private static let path = "everything"
    // private static let path = "top-headlines"
    
    //MARK: -- Methods
    // Create url path and make request
    static func getNews(from category: Category, page: Int, searchText: String?, completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        var searchParameter = ""
        if let searchText = searchText {
            searchParameter = "&q=\(searchText)"
        }
        let stringUrl = basedUrl + path + "?sources=bbc-news&language=en&page=\(page)" + searchParameter + "&apiKey=\(apiKey)"
        
        //?country=RU
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data,
                           error: error,
                           completion: completion)
        }
        
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    
    //Handle responce
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self,
                                                     from: data)
                completion(.success(model.articles))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
