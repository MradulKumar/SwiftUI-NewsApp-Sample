//
//  NetworkError.swift
//  News
//
//  Created by Mradul Kumar on 02/10/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case urlNotFound
    case invalidURL
    case requestFailed
    case decodingFailed
    case serverError(statusCode: Int)
    case unknownError
    
    var description: String? {
        switch self {
        case .urlNotFound:
            return "The URL not available"
        case .invalidURL:
            return "The URL used to fetch the data is \'Invalid\'"
        case .requestFailed:
            return "Network request failed. Please check your network connection & try again."
        case .decodingFailed:
            return "Failed to decode the response."
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
