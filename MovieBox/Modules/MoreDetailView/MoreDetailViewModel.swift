//
//  MoreDetailViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

protocol MoreDetailViewModelProtocol: ObservableObject {
    var genreText: String { get }
    var runtimeText: String { get }
    var actorsText: String { get }
    var directorText: String { get }

    func backTapped()
    func backToHomeTapped()
}


// MARK: - MoreDetailViewModelProtocol
final class MoreDetailViewModel: MoreDetailViewModelProtocol {
    private let movieDetail: MovieDetailModel?
    private let coordinator: MoreDetailCoordinatorProtocol

    init(coordinator: MoreDetailCoordinatorProtocol) {
        self.coordinator = coordinator
        self.movieDetail = coordinator.selectedMovieDetail
    }

    var genreText: String { movieDetail?.genre ?? "-" }
    var runtimeText: String { movieDetail?.runtime ?? "-" }
    var actorsText: String { movieDetail?.actors ?? "-" }
    var directorText: String { movieDetail?.director ?? "-" }

    func backTapped() {
        coordinator.back()
    }

    func backToHomeTapped() {
        coordinator.backToHome()
    }
}
