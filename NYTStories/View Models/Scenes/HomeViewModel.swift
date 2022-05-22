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
    func presentAlert(description: String)
}

final class HomeViewModel {
    
    private var articles = [Article]()
    private var service: WebServiceProtocol
    
    weak var delegate: HomeViewModelDelegate?
    
    init() {
        self.service = WebService()
    }

    func getArticles(isRefresh: Bool = false) {
        service.getArticles(url: String(format: Url.topStories, Secrets.apiKey),
                            completion: { result in
            
            switch result {
                case .success(let articles):
                    self.articles = articles!
                    self.delegate?.reloadItems()
                    
                    if isRefresh {
                        self.delegate?.endRefreshing()
                    }
                case .failure(let error):
                    self.delegate?.presentAlert(description: error.localizedDescription)
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
