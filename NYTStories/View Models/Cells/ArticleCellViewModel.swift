//
//  ArticleCellViewModell.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

protocol ArticleCellViewModelDelegate: AnyObject {
    func fetchImageData(for url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void)
}

final class ArticleCellViewModel {
    
    private var article: Article?
    private var service = WebService()
    
    weak var delegate: ArticleCellViewModelDelegate?
    
    init(article: Article) {
        self.article = article
    }
}

extension ArticleCellViewModel {
    var articleTitle: String? {
        return article?.title
    }
    
    var articleDescription: String? {
        return article?.abstract
    }
    
    var articleAuthor: String? {
        return article?.byline
    }
    
    var articleImage: String? {
        return article?.multimedia?[1].url
    }
    
    func fetchImageData(for url: String, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        service.loadData(from: url, completion: { result in
            switch result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
