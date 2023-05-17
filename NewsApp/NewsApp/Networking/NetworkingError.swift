//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import Foundation

enum NetworkingError: Error, CustomStringConvertible {
    case networkingError(_ error: Error)
    case unknown
    
    var description: String {
        switch self {
        case .networkingError(_):
            return "Sorry, the connection to our server failed"
        case .unknown:
            return "Unknown error"
        }
    }
}
