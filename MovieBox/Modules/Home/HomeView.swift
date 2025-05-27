//
//  HomeView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @Binding private var path: [MovieRoute]
    private let coordinator: MovieCoordinator

    init(viewModel: ViewModel, path: Binding<[MovieRoute]>, coordinator: MovieCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._path = path
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.isLoading {
                    ProgressView(AppString.loading)
                        .font(.montserrat(.regular, size: 16))
                } else if let error = viewModel.errorMessage {
                    Text("\(AppString.error) \(error)")
                        .font(.montserrat(.regular, size: 16))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.movies, id: \.imdbID) { movie in
                        Button {
                            viewModel.didSelectMovie(imdbID: movie.imdbID)
                        } label: {
                            MovieCardView(movie: movie)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(AppString.movies)
            .navigationDestination(for: MovieRoute.self) { route in
                switch route {
                case .detail(let imdbID):
                    coordinator.detailView(for: imdbID)
                case .moreDetail:
                    coordinator.moreDetailView()
                }
            }
            .task {
                if viewModel.movies.isEmpty {
                    await viewModel.fetchMovies()
                }
            }
        }
    }
}
