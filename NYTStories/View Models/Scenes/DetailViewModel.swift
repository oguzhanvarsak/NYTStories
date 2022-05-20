//
//  DetailViewModel.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func reloadItems()
}

final class DetailViewModel {
    
    private var article: Article?
    
    weak var delegate: DetailViewModelDelegate?
    
    init(article: Article) {
        
        self.article = article
    }
}

extension DetailViewModel {
    
    var selectedArticle: Article? {
        return article
    }
}
