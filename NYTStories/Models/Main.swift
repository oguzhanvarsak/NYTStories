//
//  Main.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

struct MainModel: Decodable {
    let status: String?
    let copyright: String?
    let section: String?
    let lastUpdated: String?
    let numResults: Int?
    let results: ArticleList?
    
    enum CodingKeys: String, CodingKey {
        case status, copyright, section, results
        case lastUpdated = "last_updated"
        case numResults = "num_results"
    }
}
