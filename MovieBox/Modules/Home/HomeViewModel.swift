//
//  HomeViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var movies: [MovieModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    let networkManager: NetworkClient
    let coordinator: MovieCoordinator

    init(networkManager: NetworkClient, coordinator: MovieCoordinator) {
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
