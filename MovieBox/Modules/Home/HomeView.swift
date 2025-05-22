//
//  HomeView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var path: [String]

    init(viewModel: HomeViewModel, path: Binding<[String]>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._path = path
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.isLoading {
                    ProgressView(AppString.loading)
                } else if let error = viewModel.errorMessage {
                    Text("\(AppString.error) \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.movies, id: \.imdbID) { movie in
                        Button {
                            path.append(movie.imdbID)
                        } label: {
                            MovieCardView(movie: movie)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(AppString.movies)
            .navigationDestination(for: String.self) { imdbID in
                DetailView(
                    viewModel: DetailViewModel(imdbID: imdbID, networkManager: viewModel.networkManager),
                    path: $path
                )
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}
