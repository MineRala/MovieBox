//
//  Endpoint.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

//https://www.omdbapi.com/?apikey=40fb0b0b&s=sta
//https://www.omdbapi.com/?apikey=40fb0b0b&i=tt0088175

import Foundation

// MARK: - API Endpoint Protocol
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoding: EncodingType { get }
}

// MARK: - APIEndpoint Enum
enum Endpoint: APIEndpoint {
    enum Constant {
        static let baseURL = "https://www.omdbapi.com/"
        static let apiKey = "40fb0b0b"

    }

    case getMovies
    case getMovieDetail(movieIMBID: String)

    var baseURL: String {
        return Constant.baseURL
    }

    var path: String {
        switch self {
        case .getMovies:
            return "?apikey=\(Constant.apiKey)&s=star"
        case .getMovieDetail(let movieIMBID):
            return "?apikey=\(Constant.apiKey)&i=\(movieIMBID)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var parameters: [String: Any]? {
        return nil
    }

    var encoding: EncodingType {
        return .urlEncoding
    }
}
