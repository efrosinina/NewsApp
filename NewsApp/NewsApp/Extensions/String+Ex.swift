//
//  String+Ex.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 30/04/2023.
//

import UIKit

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
