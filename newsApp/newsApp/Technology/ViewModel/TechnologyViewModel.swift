//
//  TechnologyViewModel.swift
//  newsApp
//
//  Created by User on 05.12.2023.
//

import Foundation

final class TechnologyViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getAnyNews(sourcesInUrl: .technology, page: page, searchText: nil) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
