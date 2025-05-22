//
//  MovieCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//


import SwiftUI

enum MovieRoute {
    case detail(imdbID: String)
    case moreDetail
}

final class MovieCoordinator: ObservableObject {
    @Published private(set) var path: [MovieRoute] = []
    var selectedMovieDetail: MovieDetailModel?
    private let networkManager: NetworkClient

    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }

    var pathBinding: Binding<[MovieRoute]> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }

    func navigateToDetail(imdbID: String) {
        selectedMovieDetail = nil

        path.append(.detail(imdbID: imdbID))
    }

    func navigateToMoreDetail(imdbID: String) {
        path.append(.moreDetail)
    }

    func popLast() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        path.removeAll()
    }

    // Start point - initial view
    func start() -> some View {
        let homeVM = HomeViewModel(networkManager: networkManager, coordinator: self)
        return HomeView(viewModel: homeVM, path: pathBinding)
    }
}
