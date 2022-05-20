//
//  HomeViewModel.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func reloadItems()
    func endRefreshing()
}

final class HomeViewModel {
    
    private var articles = [Article]()
    private var service: WebServiceProtocol
    
    weak var delegate: HomeViewModelDelegate?
    
    init(webService: WebServiceProtocol) {
        self.service = webService
    }

    func getArticles(isRefresh: Bool = false) {
        
        service.getArticles(url: URL(string: String(format: Url.topStories, Secrets.apiKey))!,
                            completion: { articles in
            if let articles = articles {
                
                self.articles.append(contentsOf: articles)
                self.delegate?.reloadItems()
                
                if isRefresh {
                    self.delegate?.endRefreshing()
                }
            }
        })
    }
}

extension HomeViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowInSection (_ section: Int) -> Int {
        return articles.count
    }
    
    func articleAtIndex (_ index: Int) -> Article? {
        return articles[index]
    }
}
