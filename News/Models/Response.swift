//
//  Response.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}
