//
//  ArticleCellViewModell.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

protocol ArticleCellViewModelDelegate: AnyObject {
    func fetchImage(for url: String, completion: @escaping (Data?) -> Void)
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
    
    func fetchImage(for url: String, completion: @escaping (Data?) -> Void) {
        service.loadData(from: url, completion: { imageData in
            completion(imageData)
        })
    }
}
