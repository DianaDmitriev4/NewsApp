//
//  NewsListViewModel.swift
//  newsApp
//
//  Created by User on 07.12.2023.
//

import Foundation

protocol NewsListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    func loadData(searchText: String?)
}

class NewsListViewModel: NewsListViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    
    // MARK: - Properties
    var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    var page = 0
    var searchText: String? = nil
    private var isSearchTextChanged = false
    
    // MARK: - Methods
    func loadData(searchText: String? = nil) {
        if self.searchText != searchText {
            page = 1
            isSearchTextChanged = true
        } else {
            page += 1
            isSearchTextChanged = false
        }
        self.searchText = searchText
    }
    // MARK: - Private func
    func handleResult(_ result: Result<[ArticleResponseObject], Error>) {
        switch result {
        case .success(let articles):
            self.convertToCellViewModel(articles)
            self.loadImage()
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    private func loadImage() {
        //        guard let url = URL(string: sections[row].imageUrl),
        //        let data = try? Data(contentsOf: url) else { return }
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel {
                    let url = article.imageUrl
                    ApiManager.getImageData(url: url) { [weak self] result in
                        
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        let viewModel = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty || isSearchTextChanged {
            let firstSection = TableCollectionViewSection(items: viewModel)
            sections = [firstSection]
        } else {
            sections[0].items += viewModel
        }
    }
    
    private func setupMockObjects() {
        sections = [
            TableCollectionViewSection(items:[ArticleCellViewModel(article: ArticleResponseObject(title: "First object title",
                                                                                                  description: "some long description some long description some long description some long description ",
                                                                                                  urlToImage: "...", date: "14.11.2022"))])
        ]
    }
}

