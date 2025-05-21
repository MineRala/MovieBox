//
//  MoreDetailViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

final class MoreDetailViewModel: ObservableObject {
    let movieDetail: MovieDetailModel

    init(movieDetail: MovieDetailModel) {
        self.movieDetail = movieDetail
    }

    var genreText: String { movieDetail.genre }
    var runtimeText: String { movieDetail.runtime }
    var actorsText: String { movieDetail.actors }
    var directorText: String { movieDetail.director }
}
