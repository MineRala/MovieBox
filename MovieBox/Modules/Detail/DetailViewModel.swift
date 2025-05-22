//
//  DetailViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager: NetworkClient
    private let imdbID: String

    init(imdbID: String, networkManager: NetworkClient) {
        self.imdbID = imdbID
        self.networkManager = networkManager
    }

    func fetchMovieDetail() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        do {
            let result: MovieDetailModel = try await networkManager.fetch(endpoint: .getMovieDetail(movieIMBID: imdbID))
            await MainActor.run {
                movieDetail = result
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

}
