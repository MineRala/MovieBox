//
//  MovieDetailModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

struct MovieDetailModel: Codable {
    let poster: String
    let title: String
    let released: String
    let plot: String
    let genre: String
    let runtime: String
    let actors: String
    let director: String

    enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case title = "Title"
        case released = "Released"
        case plot = "Plot"
        case genre = "Genre"
        case runtime = "Runtime"
        case actors = "Actors"
        case director = "Director"
    }
}
