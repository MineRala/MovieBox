//
//  MovieCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//


import SwiftUI

enum MovieRoute: Hashable {
    case detail(imdbID: String)
    case moreDetail
}

final class MovieCoordinator: ObservableObject {
    @Published var path: [MovieRoute] = []
    @Published var selectedMovieDetail: MovieDetailModel?

    let networkManager: NetworkClient

    lazy var homeCoordinator = HomeCoordinator(parent: self)
    lazy var detailCoordinator = DetailCoordinator(parent: self)
    lazy var moreDetailCoordinator = MoreDetailCoordinator(parent: self)

    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }

    var pathBinding: Binding<[MovieRoute]> {
        Binding(get: { self.path }, set: { self.path = $0 })
    }

    func start() -> some View {
        let homeVM = HomeViewModel(networkManager: networkManager, coordinator: homeCoordinator)
        return HomeView(viewModel: homeVM, path: pathBinding)
    }

    func popToRoot() {
        path.removeAll()
        selectedMovieDetail = nil
    }
}
