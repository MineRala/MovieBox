//
//  MoreDetailViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

final class MoreDetailViewModel: ObservableObject {
    private let movieDetail: MovieDetailModel?
    private weak var coordinator: MovieCoordinator?


    init(coordinator: MovieCoordinator?) {
        self.coordinator = coordinator
        self.movieDetail = coordinator?.selectedMovieDetail
    }

    var genreText: String { movieDetail?.genre ?? "-" }
    var runtimeText: String { movieDetail?.runtime ?? "-" }
    var actorsText: String { movieDetail?.actors ?? "-" }
    var directorText: String { movieDetail?.director ?? "-" }

    func backTapped() {
        coordinator?.popLast()
    }

    func backToHomeTapped() {
        coordinator?.popToRoot()
    }
}
