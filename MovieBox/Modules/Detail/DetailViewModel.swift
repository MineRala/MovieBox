//
//  DetailViewModel.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import Foundation
import SwiftUI

protocol DetailViewModelProtocol: ObservableObject {
    var movieDetail: MovieDetailModel? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func fetchMovieDetail() async
    func moreDetailsTapped()
}

// MARK: - DetailViewModelProtocol
final class DetailViewModel: DetailViewModelProtocol {
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let networkManager: NetworkClient
    private let imdbID: String
    private let coordinator: DetailCoordinatorProtocol

    init(imdbID: String, networkManager: NetworkClient, coordinator: DetailCoordinatorProtocol) {
        self.imdbID = imdbID
        self.networkManager = networkManager
        self.coordinator = coordinator
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
                coordinator.updateSelectedMovieDetail(result)
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    func moreDetailsTapped() {
        coordinator.navigateToMoreDetail()
    }
}
