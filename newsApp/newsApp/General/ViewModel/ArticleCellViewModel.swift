//
//  ArticleCellViewModel.swift
//  newsApp
//
//  Created by User on 30.11.2023.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let date: String
    let imageUrl: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title ?? ""
        description = article.description ?? ""
        date = article.date ?? ""
        imageUrl = article.urlToImage ?? ""
    }
}
