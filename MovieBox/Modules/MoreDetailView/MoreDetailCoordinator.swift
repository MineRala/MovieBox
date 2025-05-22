//
//  MoreDetailCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//

import SwiftUI

protocol MoreDetailCoordinatorProtocol: AnyObject {
    var selectedMovieDetail: MovieDetailModel? { get }

    func back()
    func backToHome()
}

final class MoreDetailCoordinator: ObservableObject, MoreDetailCoordinatorProtocol {
    public weak var parent: MovieCoordinator?

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
