//
//  HomeView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var path = [String]()
    private let networkManager: NetworkClient

    init(viewModel: HomeViewModel, networkManager: NetworkClient) {
         _viewModel = StateObject(wrappedValue: viewModel)
         self.networkManager = networkManager
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
                DetailView(viewModel: DetailViewModel(imdbID: imdbID, networkManager: networkManager), path: $path)
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}
