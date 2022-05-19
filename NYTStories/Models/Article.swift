//
//  Article.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation

typealias ArticleList = [Article]

struct Article: Decodable {
    
    let section: String?
    let subsection: String?
    let title: String?
    let abstract: String?
    let url: String?
    let uri: String?
    let byline: String?
    let item_type: String?
    let updated_date: String?
    let created_date: String?
    let published_date: String?
    let material_type_facet: String?
    let kicker: String?
    let des_facet: [String]?
    let org_facet: [String]?
    let per_facet: [String]?
    let geo_facet: [String]?
    let multimedia: [Multimedia]?
    let short_url: String?
}

struct Multimedia: Decodable {
    
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
}
