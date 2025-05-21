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

    private let networkManager: NetworkClient

    init(networkManager: NetworkClient = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchMovies() async {
        Task {
            await MainActor.run {
                self.isLoading = true
                self.errorMessage = nil
            }

            do {
                let result: MovieResult = try await networkManager.fetch(endpoint: .getMovies)

                await MainActor.run {
                    self.movies = result.search
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

}

