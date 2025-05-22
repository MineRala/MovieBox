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

    lazy var homeCoordinator: HomeCoordinatorProtocol = HomeCoordinator(parent: self)
    lazy var detailCoordinator: DetailCoordinatorProtocol = DetailCoordinator(parent: self)
    lazy var moreDetailCoordinator: MoreDetailCoordinatorProtocol = MoreDetailCoordinator(parent: self)

    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }

    var pathBinding: Binding<[MovieRoute]> {
        Binding(get: { self.path }, set: { self.path = $0 })
    }

    func start() -> some View {
        let homeVM = HomeViewModel(networkManager: networkManager, coordinator: homeCoordinator)
        return HomeView<HomeViewModel>(
            viewModel: homeVM,
            path: pathBinding,
            coordinator: self
        )
    }

    func detailView(for imdbID: String) -> some View {
        let detailVM = DetailViewModel(
            imdbID: imdbID,
            networkManager: networkManager,
            coordinator: detailCoordinator
        )
        return DetailView(viewModel: detailVM)
    }

    func moreDetailView() -> some View {
        let moreDetailVM = MoreDetailViewModel(coordinator: moreDetailCoordinator)
        return MoreDetailView(viewModel: moreDetailVM)
    }

    func popToRoot() {
        path.removeAll()
        selectedMovieDetail = nil
    }
}
