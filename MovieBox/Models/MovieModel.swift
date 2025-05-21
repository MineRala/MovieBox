//
//  MovieModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

//MARK: - MovieResult
struct MovieResult: Decodable {
    let search: [MovieModel]

    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

//MARK: - MovieModel
struct MovieModel: Decodable {
    let poster: String
    let title: String
    let year: String
    let imdbID: String

    enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case title = "Title"
        case year = "Year"
        case imdbID
    }
}
