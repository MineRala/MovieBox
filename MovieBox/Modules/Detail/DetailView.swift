//
//  DetailView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject private var viewModel: DetailViewModel
    @State private var showMoreDetails = false
    @Binding var path: [String]

    init(viewModel: DetailViewModel, path: Binding<[String]>) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        VStack(spacing: 8) {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text("\(AppString.error) \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let movieDetail = viewModel.movieDetail {
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

                Button {
                    showMoreDetails = true
                } label: {
                    Text(AppString.moreDetails)
                        .bold()
                        .foregroundColor(.blue)
                }
                .padding(.top, 8)
            } else {
                Text(AppString.loading)
            }
        }
        .task {
            await viewModel.fetchMovieDetail()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationDestination(isPresented: $showMoreDetails) {
            if let movieDetail = viewModel.movieDetail {
                MoreDetailView(viewModel: MoreDetailViewModel(movieDetail: movieDetail),path: $path)
            }
        }
    }
}
