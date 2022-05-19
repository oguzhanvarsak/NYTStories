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
    let last_updated: String?
    let num_results: Int?
    let results: ArticleList?
}
