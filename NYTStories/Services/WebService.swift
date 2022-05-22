//
//  WebService.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import UIKit
import Foundation

protocol WebServiceProtocol {
    func parseJSON(data: Data) -> Result<MainModel?, NetworkError>
    func getArticles(url: String, completion: @escaping (Result<ArticleList?, NetworkError>) -> Void)
    func loadData(from url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void)
}

class WebService: WebServiceProtocol {
    let utilityQueue = DispatchQueue.global(qos: .utility)

    func getArticles(url: String, completion: @escaping (Result<ArticleList?, NetworkError>) -> Void) {
        let session = URLSession.init(configuration: .default)
        
        if let url = URL(string: url) {
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.noInternetConnection))
                } else {
                    if let data = data {
                        if let articleList = try? self.parseJSON(data: data).get() {
                            completion(.success(articleList.results))
                        }
                    }
                }
            }
            
            task.resume()
        } else {
            completion(.failure(.badUrl))
        }
        
       
    }
    
    func parseJSON(data: Data) -> Result<MainModel?, NetworkError> {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(MainModel.self, from: data)
            
            return .success(decodedData)
        } catch {
            print(error.localizedDescription)
            return .failure(.errorParsingJSON(error.localizedDescription))
        }
    }
    
    func loadData(from url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        utilityQueue.async {
            if let url = URL(string: url) {
                if let data = try? Data(contentsOf: url) {
                    completion(.success(data))
                } else {
                    completion(.failure(.dataReturnedNil))
                }
            } else {
                completion(.failure(.badUrl))
            }
        }
    }
}
