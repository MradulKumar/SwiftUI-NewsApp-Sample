//
//  NetworkManager.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import Foundation
import Combine

// Define the NetworkSession protocol
protocol NetworkSession {
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

// URLSessionAdapter to act as a wrapper around URLSession
class URLSessionAdapter: NetworkSession {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return session.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}

class NetworkManager {
    private let session: NetworkSession
    
    // Inject NetworkSession, default to URLSessionAdapter
    init(session: NetworkSession = URLSessionAdapter()) {
        self.session = session
    }
    
    func fetchNews(from url: URL) -> AnyPublisher<NewsResponse, Error> {
        return session.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,                      
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(statusCode: (result.response as? HTTPURLResponse)?.statusCode ?? -1)
                }
                return result.data
            }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
