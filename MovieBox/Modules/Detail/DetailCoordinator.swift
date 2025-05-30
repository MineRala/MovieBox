//
//  DetailCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//

import SwiftUI

protocol DetailCoordinatorProtocol: AnyObject {
    func navigateToMoreDetail()
    func updateSelectedMovieDetail(_ detail: MovieDetailModel)
}

final class DetailCoordinator: ObservableObject, DetailCoordinatorProtocol {
    public weak var parent: MovieCoordinator?

    init(parent: MovieCoordinator) {
        self.parent = parent
    }

    func navigateToMoreDetail() {
        guard let parent else { return }
        parent.pathAppend(route: .moreDetail)
    }

    func updateSelectedMovieDetail(_ detail: MovieDetailModel) {
        guard let parent else { return }
        parent.setSelectedMovieDetail(model: detail)
    }
}
