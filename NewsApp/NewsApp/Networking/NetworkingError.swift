//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 05/05/2023.
//

import UIKit

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
