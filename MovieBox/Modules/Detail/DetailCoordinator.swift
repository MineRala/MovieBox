//
//  DetailCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//

import SwiftUI

final class DetailCoordinator: ObservableObject {
    weak var parent: MovieCoordinator?

    init(parent: MovieCoordinator) {
        self.parent = parent
    }

    func navigateToMoreDetail() {
        guard let parent else { return }
        parent.path.append(.moreDetail)
    }

}
