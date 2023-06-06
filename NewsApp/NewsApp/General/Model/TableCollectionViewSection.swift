//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 11/05/2023.
//

import UIKit

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
