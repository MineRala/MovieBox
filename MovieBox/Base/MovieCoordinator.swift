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
    @Published private var path: [MovieRoute] = []
    @Published private var selectedMovieDetail: MovieDetailModel?

    let networkManager: NetworkClient

    lazy var homeCoordinator: HomeCoordinatorProtocol = HomeCoordinator(parent: self)
    lazy var detailCoordinator: DetailCoordinatorProtocol = DetailCoordinator(parent: self)
    lazy var moreDetailCoordinator: MoreDetailCoordinatorProtocol = MoreDetailCoordinator(parent: self)

    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }

    private var pathBinding: Binding<[MovieRoute]> {
        Binding(get: { self.path }, set: { self.path = $0 })
    }

    func start() -> some View {
        let homeVM = HomeViewModel(networkManager: networkManager, coordinator: homeCoordinator)
        let homeView = HomeView(viewModel: homeVM)

        return NavigationStack(path: pathBinding) {
            homeView
                .navigationDestination(for: MovieRoute.self) { route in
                    switch route {
                    case .detail(let imdbID):
                        self.detailView(for: imdbID)
                    case .moreDetail:
                        self.moreDetailView()
                    }
                }
        }
    }

    func popToRoot() {
        path.removeAll()
        selectedMovieDetail = nil
    }

    func pathAppend(route: MovieRoute) {
        path.append(route)
    }

    func removePathLast() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func setSelectedMovieDetail(model: MovieDetailModel?) {
        selectedMovieDetail = model
    }

    func getSelectedMovieDetail() -> MovieDetailModel? {
        selectedMovieDetail
    }
}

// MARK: - Private
extension MovieCoordinator {
    private func detailView(for imdbID: String) -> some View {
        let detailVM = DetailViewModel(
            imdbID: imdbID,
            networkManager: networkManager,
            coordinator: detailCoordinator
        )
        return DetailView(viewModel: detailVM)
    }

    private func moreDetailView() -> some View {
        let moreDetailVM = MoreDetailViewModel(coordinator: moreDetailCoordinator)
        return MoreDetailView(viewModel: moreDetailVM)
    }
}
