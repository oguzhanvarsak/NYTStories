//
//  DetailViewModel.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

final class DetailViewModel {
    
    private var article: Article?
    private var dateFormatter = Formatter()
    
    init(article: Article) {
        
        self.article = article
    }
}

extension DetailViewModel {
    var selectedArticle: Article? {
        return article
    }
    
    func getDate(from dateString: String?) -> String {
        if let dateString = dateString {
            return dateFormatter.getDate(from: dateString)
        }
        
        return ""
    }
}
