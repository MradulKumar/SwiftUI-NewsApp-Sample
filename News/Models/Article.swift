//
//  Article.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import Foundation

struct Article: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let source: Article.Source?
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
    
    var formattedPublishedDate: String? {
        guard let publishedAt = publishedAt else { return nil }
        
        let dateFormatter = ISO8601DateFormatter() // To parse ISO 8601 format dates
        if let date = dateFormatter.date(from: publishedAt) {
            let localFormatter = DateFormatter()
            localFormatter.dateStyle = .medium
            localFormatter.timeStyle = .short
            localFormatter.locale = Locale.current
            localFormatter.timeZone = TimeZone.current
            
            return localFormatter.string(from: date)
        }
        
        return nil
    }
    
    var articleDetailURL: URL? {
        guard let url = self.url else { return nil }
        return URL(string: url)
    }
}

extension Article {
    
    struct Source: Codable {
        let id: String?
        let name: String?
    }
}

extension Article {
    
    static let mockArticle = Article(source: Source(id: "reuters", name: "Reuters"),
                                     author: "John Geddie, Tim Kelly",
                                     title: "Japan's new PM Ishiba unveils cabinet ahead of snap election - Reuters",
                                     description: "Japan's new Prime Minister Shigeru Ishiba on Tuesday unveiled his cabinet as he seeks to heal party divisions and secure a national mandate with an Oct. 27 snap election.",
                                     url: "https://www.reuters.com/world/asia-pacific/japans-new-pm-ishiba-set-be-formally-anointed-unveil-cabinet-2024-10-01/",
                                     urlToImage: "https://www.reuters.com/resizer/v2/KBXLGGB7KBNSPBQL6T6YERWMBI.jpg?auth=7e023a7138824e9f0b173b719133cc16b4199091d1ebde29cdabb4d9c619aa8d&height=1005&width=1920&quality=80&smart=true",
                                     publishedAt: "2024-10-01T08:54:48Z",
                                     content: "null")
    
    static let mockArticleInvalid = Article(source: Source(id: "reuters", name: "Reuters"),
                                            author: "John Geddie, Tim Kelly",
                                            title: "Japan's new PM Ishiba unveils cabinet ahead of snap election - Reuters",
                                            description: "Japan's new Prime Minister Shigeru Ishiba on Tuesday unveiled his cabinet as he seeks to heal party divisions and secure a national mandate with an Oct. 27 snap election.",
                                            url: "https://www.reuters.com/world/asia-pacific/japans-new-pm-ishiba-set-be-formally-anointed-unveil-cabinet-2024-10-01/",
                                            urlToImage: "https://www.reuters.com/resizer/v2/KBXLGGB7KBNSPBQL6T6YERWMBI.jpg?auth=7e023a7138824e9f0b173b719133cc16b4199091d1ebde29cdabb4d9c619aa8d&height=1005&width=1920&quality=80&smart=true",
                                            publishedAt: "invalid-date",
                                            content: "null")
    
    
}
