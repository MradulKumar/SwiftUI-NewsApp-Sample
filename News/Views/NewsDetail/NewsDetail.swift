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

                    //Date
                    if let publishedDate = article.formattedPublishedDate {
                        Text("Published On : \(publishedDate)")
                            .font(.headline)
                            .lineLimit(2)
                            .minimumScaleFactor(0.75)
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
                        .frame(width: 260, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                }
            }
        }
    }
}
