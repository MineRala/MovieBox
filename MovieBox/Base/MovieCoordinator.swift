//
//  MovieCoordinator.swift
//  MovieBox
//
//  Created by Mine Rala on 22.05.2025.
//


import SwiftUI

final class MovieCoordinator: ObservableObject {
    @Published var path: [String] = []
    private let networkManager: NetworkClient

    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }

    var pathBinding: Binding<[String]> {
           Binding(
               get: { self.path },
               set: { self.path = $0 }
           )
       }

    func start() -> some View {
        let homeVM = HomeViewModel(networkManager: networkManager)
        return HomeView(viewModel: homeVM, path: pathBinding)
    }

    func navigateToDetail(imdbID: String) {
        path.append(imdbID)
    }

    func navigateToRoot() {
        path.removeAll()
    }
}
