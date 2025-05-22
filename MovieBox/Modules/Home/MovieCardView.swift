//
//  MovieCardView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct MovieCardView: View {
    let movie: MovieModel

    var body: some View {
        HStack(spacing: 16) {
            CustomAsyncMovieImageView(urlString: movie.poster, width: 60, height: 90, cornerRadius: 8)
            LazyVStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.year)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
