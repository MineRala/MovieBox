//
//  HomeCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//

import SwiftUI

final class HomeCoordinator: ObservableObject {
    weak var parent: MovieCoordinator?

    init(parent: MovieCoordinator) {
        self.parent = parent
    }

    func navigateToDetail(imdbID: String) {
        guard let parent else { return }
        parent.selectedMovieDetail = nil
        parent.path.append(.detail(imdbID: imdbID))
    }
}
