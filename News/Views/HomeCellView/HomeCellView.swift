//
//  HomeCellView.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import SwiftUI

struct NewsRowView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            //Date
            if let publishedDate = article.formattedPublishedDate {
                Text(publishedDate)
                    .font(.headline)
                    .lineLimit(maxLineLimit)
                    .minimumScaleFactor(minScaleFactor)
            }
            
            //Image
            ArticleImage(urlToImage: article.urlToImage)

            //Title
            Text(article.title)
                .font(.headline)
                .lineLimit(maxLineLimit)
                .minimumScaleFactor(minScaleFactor)
            
            //Description
            if let desc = article.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .minimumScaleFactor(minScaleFactor)
                    .lineLimit(maxLineLimit)
            }
        }
    }
}

#Preview {
    NewsRowView(article: Article.mockArticle)
}
