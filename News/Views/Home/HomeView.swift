//
//  HomeView.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.newsArticles, id: \.id) { article in
                        NavigationLink(destination: NewsDetailView(article: article)) {
                            NewsRowView(article: article)
                        }
                        .onAppear {
                            // Detecting when the user reaches the last article
                            if article == viewModel.newsArticles.last {
                                viewModel.fetchNews()
                            }
                        }
                    }
                    if viewModel.isFetchingMore {
                        ProgressView()
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle("News")
                .onAppear {
                    if viewModel.newsArticles.isEmpty {
                        viewModel.fetchNews(reset: true)
                    }
                }
            }
            
            //show loading on full page
            if viewModel.isLoading {
                LoadingView()
            }
            
        }
    }
}
