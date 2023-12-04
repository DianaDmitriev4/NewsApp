//
//  GeneralViewModel.swift
//  newsApp
//
//  Created by User on 30.11.2023.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    
    // MARK: - Properties
    var numberOfCells: Int {
        return  articles.count
    }
    
    private  var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    private func loadData() {
        ApiManager.getNews { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
        //        guard let url = URL(string: articles[row].imageUrl),
        //        let data = try? Data(contentsOf: url) else { return }
        for (index, article) in articles.enumerated() {
            
            ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0)
        }
    }
    
    private func setupMockObjects() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First object title",
                                                                description: "First object description in the mock object",
                                                                urlToImage: "...",
                                                                date: "12.10.2014"))
            //            ArticleResponseObject(title: "First object title",
            //                                  description: "First object description in the mock object",
            //                                  urlToImage: "...",
            //                                  date: "12.10.2014"),
            //            ArticleResponseObject(title: "Second object title",
            //                                  description: "Second object description in the mock object",
            //                                  urlToImage: "...",
            //                                  date: "12.10.2014"),
            //            ArticleResponseObject(title: "Third object title",
            //                                  description: "Third object description in the mock object",
            //                                  urlToImage: "...",
            //                                  date: "12.10.2014"),
            //            ArticleResponseObject(title: "Fourth object title",
            //                                  description: "Fourth object description in the mock object",
            //                                  urlToImage: "...",
            //                                  date: "12.10.2014"),
            //            ArticleResponseObject(title: "Fifth object title",
            //                                  description: "Fifth object description in the mock object",
            //                                  urlToImage: "...",
            //                                  date: "12.10.2014"),
        ]
    }
}
