//
//  NetworkManagerTest.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import XCTest
import Combine
@testable import News

class NetworkManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }


    var cancellables = Set<AnyCancellable>()

    func testFetchNewsSuccess() {
        let mockSession = MockNetworkSession()
        let news = NewsResponse(status: "ok", totalResults: 1, articles: [Article.mockArticle])
        mockSession.mockData = try! JSONEncoder().encode(news)
        mockSession.mockError = nil

        let networkManager = NetworkManager(session: mockSession)
        let url = URL(string: "https://mocknewsapi.org/v2/top-headlines?country=us&apiKey=d425e4b7d6434f618ae82374253f4dc8")!
        let expectation = XCTestExpectation(description: "News fetched successfully")

        networkManager.fetchNews(from: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { fetchedNews in
                XCTAssertEqual(fetchedNews.articles.count, 1)
                XCTAssertEqual(fetchedNews.totalResults, 1)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchNewsFailure() {
        let mockSession = MockNetworkSession()
        mockSession.mockError = URLError(.badServerResponse)

        let networkManager = NetworkManager(session: mockSession)
        let url = URL(string: "https://mocknewsapi.org/v2/top-headlines?country=us&apiKey=d425e4b7d6434f618ae82374253f4dc8")!
        let expectation = XCTestExpectation(description: "News fetch failed")

        networkManager.fetchNews(from: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }
}
