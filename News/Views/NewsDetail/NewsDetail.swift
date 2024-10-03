//
//  NewsDetail.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import SwiftUI

struct NewsDetailView: View {
    let article: Article
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8.0) {
                    //Image
                    ArticleImage(urlToImage: article.urlToImage)
                    
                    //Date
                    if let publishedDate = article.formattedPublishedDate {
                        Text("Published On : \(publishedDate)")
                            .font(.headline)
                            .lineLimit(maxLineLimit)
                            .minimumScaleFactor(minScaleFactor)
                    }
                    
                    //author
                    if let author = article.author {
                        Text("Author : \(author)")
                            .font(.body)
                            .padding(.top, 10)
                    }
                    
                    //Title
                    Text(article.title)
                        .font(.title2)
                        .bold()
                        .padding(.top, 10)
                    
                    //Description
                    if let description = article.description {
                        Text(description)
                            .font(.body)
                            .padding(.top, 10)
                    }
                }
                .padding()
            }
            .navigationTitle("News Detail")
            .navigationBarTitleDisplayMode(.inline)
            
            if let articleDetailURL = article.articleDetailURL {
                Link(destination: articleDetailURL) {
                    Text("More Details")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 240, height: 44, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                }
                .padding()
            }
        }
    }
}
