//
//  HomeViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var movies: [MovieModel] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func fetchMovies() async
    func didSelectMovie(imdbID: String)
}

// MARK: - HomeViewModelProtocol
final class HomeViewModel: HomeViewModelProtocol {
    @Published var movies: [MovieModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published private(set) var navigationRoute: MovieRoute?


    let networkManager: NetworkClient
    let coordinator: HomeCoordinatorProtocol

    init(networkManager: NetworkClient, coordinator: HomeCoordinatorProtocol) {
        self.networkManager = networkManager
        self.coordinator = coordinator
    }

    func fetchMovies() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        do {
            let result: MovieResult = try await networkManager.fetch(endpoint: .getMovies)
            await MainActor.run {
                movies = result.search
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    func didSelectMovie(imdbID: String) {
        coordinator.navigateToDetail(imdbID: imdbID)
    }
}

