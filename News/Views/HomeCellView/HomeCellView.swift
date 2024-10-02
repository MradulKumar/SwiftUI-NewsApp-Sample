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
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
            
            //Image
            if let urlToImage = article.urlToImage, let imageUrl = URL(string: urlToImage) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(height: 150)
                            .cornerRadius(10)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(10)
            } else {
                Image(systemName: "photo")
                    .frame(height: 150)
                    .cornerRadius(10)
            }
            
            //Title
            Text(article.title)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
            
            //Description
            if let desc = article.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .minimumScaleFactor(0.75)
                    .lineLimit(2)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}

#Preview {
    NewsRowView(article: Article.mockArticle)
}
