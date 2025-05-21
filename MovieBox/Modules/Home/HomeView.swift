//
//  HomeView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
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
                        ZStack {
                            NavigationLink(destination: DetailView(imdbID: movie.imdbID)) {
                                EmptyView()
                            }
                            .opacity(0)
                            MovieCardView(movie: movie)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)

                }
            }
            .navigationTitle("Movies")
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}
