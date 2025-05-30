//
//  HomeCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//

import SwiftUI

protocol HomeCoordinatorProtocol: AnyObject {
    func navigateToDetail(imdbID: String)
}

final class HomeCoordinator: ObservableObject, HomeCoordinatorProtocol {
    public weak var parent: MovieCoordinator?

    init(parent: MovieCoordinator) {
        self.parent = parent
    }

    func navigateToDetail(imdbID: String) {
        guard let parent else { return }
        parent.setSelectedMovieDetail(model: nil)
        parent.pathAppend(route: .detail(imdbID: imdbID))
    }
}
