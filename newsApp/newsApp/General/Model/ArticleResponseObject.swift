//
//  ArticleResponseObject.swift
//  newsApp
//
//  Created by User on 30.11.2023.
//

import UIKit

struct ArticleResponseObject: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt" // Если ключи не совпадают, то используем raw value
    }
}
