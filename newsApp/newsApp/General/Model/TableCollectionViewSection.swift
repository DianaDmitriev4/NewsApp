//
//  TableCollectionViewSection.swift
//  newsApp
//
//  Created by User on 06.12.2023.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
