//
//  NewsResponseObject.swift
//  newsApp
//
//  Created by User on 30.11.2023.
//

import UIKit

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
