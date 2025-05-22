//
//  DetailView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI
import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel

    var body: some View {
        VStack(spacing: 8) {
            if viewModel.isLoading {
                ProgressView().padding()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let movieDetail = viewModel.movieDetail {
                CustomAsyncMovieImageView(
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

                Button {
                    viewModel.moreDetailsTapped()
                } label: {
                    Text("More Details")
                        .bold()
                        .foregroundColor(.blue)
                }
                .padding(.top, 8)
            } else {
                Text("Loading...")
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .task {
            await viewModel.fetchMovieDetail()
        }
    }
}
