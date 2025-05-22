//
//  HomeView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var path: [MovieRoute]

    init(viewModel: HomeViewModel, path: Binding<[MovieRoute]>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._path = path
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
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
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Movies")
            .navigationDestination(for: MovieRoute.self) { route in
                switch route {
                case .detail(let imdbID):
                    DetailView(viewModel: DetailViewModel(imdbID: imdbID, networkManager: viewModel.networkManager, coordinator: viewModel.coordinator))
                case .moreDetail:
                    MoreDetailView(viewModel: MoreDetailViewModel(coordinator: viewModel.coordinator))
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
