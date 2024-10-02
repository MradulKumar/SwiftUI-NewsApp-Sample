//
//  URLUtility.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import Foundation

class URLUtility {
    
    static let shared = URLUtility()  // Singleton instance
    
    private let apiKey = "d425e4b7d6434f618ae82374253f4dc8"
    private let baseURL = "https://newsapi.org/v2"
    
    // Private constructor to prevent instantiation
    private init() {}
    
    // Function to generate a URL for top headlines
    func getTopHeadlinesURL(country: String? = nil, category: String? = nil, page: Int = 1, pageSize: Int = 20) -> URL? {
        var urlString = "\(baseURL)/top-headlines?apiKey=\(apiKey)&page=\(page)&pageSize=\(pageSize)"
        
        if let country = country {
            urlString += "&country=\(country)"
        }
        
        if let category = category {
            urlString += "&category=\(category)"
        }
        
        return URL(string: urlString)
    }
}
