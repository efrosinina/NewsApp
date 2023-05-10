//
//  APIManager.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit

final class APIManager {
    //MARK: -- Properties
    private static let apiKey = "c200d5fceabf4c948e525470c3ef3cc2"
    private static let basedUrl = "https://newsapi.org/v2/"
    private static let path = "everything"
    private static let topPath = "top-headlines"
    
    // Create url path and make request
    static func getGeneralNews(completion: @escaping (Result<[GeneralArticleResponseObject], Error>) -> ()) {
        let stringUrl = basedUrl + path + "?sources=bbc-news&language=en" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponseGeneral(data: data,
                                  error: error,
                                  completion: completion)
        }
        
        session.resume()
    }
    
    //MARK: -- Methods
    static func getBusinessNews(completion: @escaping (Result<[BusinessArticleResponseObject], Error>) -> ()) {
        let stringUrl = basedUrl + topPath + "?category=business&language=en" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponseBusiness(data: data,
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
    private static func handleResponseGeneral(data: Data?,
                                              error: Error?,
                                              completion: @escaping (Result<[GeneralArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(GeneralNewsResponseObject.self,
                                                     from: data)
                completion(.success(model.articles))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
    private static func handleResponseBusiness(data: Data?,
                                               error: Error?,
                                               completion: @escaping (Result<[BusinessArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(BusinessNewsResponseObject.self,
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
