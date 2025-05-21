//
//  DetailViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager: NetworkClient
    private let imdbID: String

    init(imdbID: String, networkManager: NetworkClient = NetworkManager()) {
        self.imdbID = imdbID
        self.networkManager = networkManager
        Task {
            await fetchMovieDetail()
        }
    }

    func fetchMovieDetail() async {
        isLoading = true
        errorMessage = nil
        do {
            let result: MovieDetailModel = try await networkManager.fetch(endpoint: .getMovieDetail(movieIMBID: imdbID))
            movieDetail = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
