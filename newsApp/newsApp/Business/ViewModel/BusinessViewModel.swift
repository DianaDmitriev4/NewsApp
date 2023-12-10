//
//  BusinessViewModel.swift
//  newsApp
//
//  Created by User on 05.12.2023.
//

import Foundation

final class BusinessViewModel: NewsListViewModel {
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getAnyNews(sourcesInUrl: .business,
                              page: page,
                              searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
    override func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModel = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModel.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModel)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModel
        }
    }
}
