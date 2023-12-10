//
//  ApiManager.swift
//  newsApp
//
//  Created by User on 02.12.2023.
//

import UIKit

final class ApiManager {
    enum SourceInUrl: String {
        case general = "general"
        case business = "business"
        case technology = "technology"
    }
    
    private static let apiKey = "6e6f3b9fa1184eb9b83dc6dc65042fc3"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "top-headlines"
    
    // Create url path and make request
    static func getAnyNews(sourcesInUrl: SourceInUrl,
                           page: Int,
                           searchText: String?,
                           completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        var searchParam = ""
        if let searchText {
            searchParam = "&q=\(searchText)"
        }
        
        let stringUrl = baseUrl + path + "?category=\(sourcesInUrl.rawValue)&language=en&page=\(page)" + searchParam + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        //  URL - наш запрос с помощью dataTask. Но замыкание срабатывает когда пришел ответ от сервера
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data,
                           error: error,
                           completion: completion)
        }
        
        // Вызов этого метода отправляет запрос в интернет
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data {
                completion(.success(data))
            }
            if let error {
                completion(.failure(error))
            }
        }
        
        session.resume()
    }
    
    // Handle response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data {
            // Чтобы посмотреть что пришло с сервера в мэсседже. Преобразовываем ответ с сервера в json объект
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self,
                                                     from: data)
                completion(.success(model.articles))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
