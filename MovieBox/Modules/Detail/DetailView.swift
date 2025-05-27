//
//  DetailView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct DetailView<ViewModel: DetailViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 8) {
            if viewModel.isLoading {
                ProgressView().padding()
            } else if let error = viewModel.errorMessage {
                Text("\(AppString.error) \(error)")
                    .font(.montserrat(.regular, size: 16))
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
                .padding(.top)
                Text(movieDetail.title)
                    .font(.montserrat(.semiBold, size: 22))
                    .multilineTextAlignment(.center)
                Text(movieDetail.released)
                    .font(.montserrat(.bold, size: 18))
                Text(movieDetail.plot)
                    .font(.montserrat(.regular, size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                    .padding(.horizontal, 8)

                Button {
                    viewModel.moreDetailsTapped()
                } label: {
                    Text(AppString.moreDetails)
                        .font(.montserrat(.medium, size: 16))
                        .foregroundColor(.blue)
                }
                .padding(.top, 8)
            } else {
                Text(AppString.loading)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .task {
            await viewModel.fetchMovieDetail()
        }
    }
}
