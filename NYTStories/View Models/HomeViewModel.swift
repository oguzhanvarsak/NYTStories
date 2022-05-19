//
//  HomeViewModel.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

struct HomeViewModel {
    
    let articles: ArticleList
}

extension HomeViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

struct ArticleViewModel {
    
    private let article: Article
    
}

extension ArticleViewModel {
    
    init (_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var currentArticle: Article {
        return self.article
    }
}
