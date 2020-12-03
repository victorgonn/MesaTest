//
//  NewsDto.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation

struct NewsRequest: Codable {
    var current_page: Int
    var per_page: Int
    var published_at: String
}

struct NewsResponse: Codable {
    var pagination: Pagination?
    var data: [News]
}

struct Pagination: Codable {
    var current_page: Int
    var per_page: Int
    var total_pages: Int
    var total_items: Int
}

struct News: Codable {
    var title: String
    var description: String
    var content: String
    var author: String
    var published_at: String
    var highlight: Bool
    var url: String
    var image_url: String
}
