//
//  AppError.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case invalidResponse
    case invalidRequest
    case invalidData
    case invalidHTTPStatusCode(statusCode: Int)
    case networkError(Error)
    case decodingError
    case unauthorized
    case paymentRequired
    case pageNotFound
    case noInternetConnection
    case unknown

    var errorMessage: String {
        switch self {
        case .invalidURL:
            return AppString.invalidURL
        case .invalidResponse:
            return AppString.invalidResponse
        case .invalidRequest:
            return AppString.invalidRequest
        case .invalidData:
            return AppString.invalidData
        case .invalidHTTPStatusCode(let statusCode):
            return AppString.invalidHTTPStatusCode + "\(statusCode)"
        case .networkError(_):
            return AppString.networkError
        case .decodingError:
            return AppString.decodingError
        case .unauthorized:
            return AppString.unauthorized
        case .paymentRequired:
            return AppString.paymentRequired
        case .pageNotFound:
            return AppString.pageNotFound
        case .noInternetConnection:
            return AppString.noInternetConnection
        case .unknown:
            return AppString.unowned
        }
    }
}
