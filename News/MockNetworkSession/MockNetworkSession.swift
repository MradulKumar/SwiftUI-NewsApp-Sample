//
//  Untitled.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import Foundation
import Combine

class MockNetworkSession: NetworkSession {
    var mockData: Data?
    var mockError: URLError?

    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = mockError {
            return Fail<(data: Data, response: URLResponse), URLError>(error: error)
                .eraseToAnyPublisher()
        }
        
        guard let data = mockData else {
            return Fail<(data: Data, response: URLResponse), URLError>(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        // Simulate a successful response with a dummy URL response
        let urlResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: data.count, textEncodingName: nil)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return Just((data: data, response: (response ?? urlResponse)))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
