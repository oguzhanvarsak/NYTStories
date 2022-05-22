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
    let itemType: String?
    let updatedDate: String?
    let createdDate: String?
    let publishedDate: String?
    let materialTypeFacet: String?
    let kicker: String?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let multimedia: [Multimedia]?
    let shortUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case section, subsection, title, abstract, url, uri, byline, kicker, multimedia
        case itemType = "item_type"
        case updatedDate = "updated_date"
        case createdDate = "created_date"
        case publishedDate = "published_date"
        case materialTypeFacet = "material_type_facet"
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case shortUrl = "short_url"
        
    }
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
