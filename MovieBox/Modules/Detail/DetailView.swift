//
//  DetailView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct DetailView: View {
    let imdbID: String
    @StateObject private var viewModel: DetailViewModel

    init(imdbID: String) {
        self.imdbID = imdbID
        _viewModel = StateObject(wrappedValue: DetailViewModel(imdbID: imdbID))
    }

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .padding()
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        } else if let movieDetail = viewModel.movieDetail {
            VStack(spacing: 8) {
                AsyncMovieImageView(
                    urlString: movieDetail.poster,
                    width: 150,
                    height: 200,
                    cornerRadius: 12
                )

                Text(movieDetail.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text(movieDetail.released)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(movieDetail.plot)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                    .padding(.horizontal, 8)

                Button(action: {
                    // Action
                }) {
                    Text("More Details")
                        .bold()
                        .foregroundColor(.blue)
                }
                .padding(.top, 8)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        } else {
            Text("Loading...")
        }
    }
}
