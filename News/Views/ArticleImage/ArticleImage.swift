//
//  ArticleImage.swift
//  News
//
//  Created by Mradul Kumar on 03/10/24.
//

import SwiftUI

struct ArticleImage: View {
    var urlToImage: String?
    
    var body: some View {
        if let urlToImage = urlToImage, let imageUrl = URL(string: urlToImage) {
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
    }
}
