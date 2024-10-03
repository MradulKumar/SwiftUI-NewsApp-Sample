//
//  HomeViewModel.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import Foundation
import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsArticles = [Article]()
    @Published var isLoading: Bool = false
    @Published var isFetchingMore = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let pageSize = 20
    private var currentPage = 1
    private var totalResults = -1
    
    func fetchNews(reset: Bool = false) {
        //if a fetch request is already in progress
        if isFetchingMore { return }
        
        //if all the articles are fetched, no need to fetch more
        if newsArticles.count == totalResults { return }
        
        
        //for the first time pass reset = true
        if reset {
            isLoading = true
            totalResults = -1
            currentPage = 1
            newsArticles.removeAll()
        } else {
            isFetchingMore = true
        }
        
        guard let url = URLUtility.shared.getTopHeadlinesURL(country: "us", page: currentPage, pageSize: pageSize) else {
            self.errorMessage = "Invalid URL."
            return
        }
        
        NetworkManager().fetchNews(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading = false
                    self?.isFetchingMore = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.newsArticles.append(contentsOf: response.articles)
                self?.currentPage += 1
                self?.totalResults = response.totalResults ?? 0
                self?.isLoading = false
                self?.isFetchingMore = false
            })
            .store(in: &cancellables)
    }
    
    func refreshNews() {
        fetchNews(reset: true)
    }
}
