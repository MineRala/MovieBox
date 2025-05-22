//
//  MoreDetailCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//

import SwiftUI

final class MoreDetailCoordinator: ObservableObject {
    weak var parent: MovieCoordinator?

    init(parent: MovieCoordinator) {
        self.parent = parent
    }

    var selectedMovieDetail: MovieDetailModel? {
        guard let parent else { return nil }
        return parent.selectedMovieDetail
    }

    func back() {
        guard let parent, !parent.path.isEmpty else { return }
        parent.path.removeLast()
    }

    func backToHome() {
        guard let parent else { return }
        parent.popToRoot()
    }
}
