//
//  GeneralViewModel.swift
//  newsApp
//
//  Created by User on 30.11.2023.
//

import Foundation

final class GeneralViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getAnyNews(sourcesInUrl: .general,
                              page: page,
                              searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
