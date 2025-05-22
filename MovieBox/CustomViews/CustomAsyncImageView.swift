//
//  CustomAsyncImageView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct CustomAsyncMovieImageView: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        if let url = URL(string: urlString), urlString != AppString.NA {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: width, height: height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                        .cornerRadius(cornerRadius)
                case .failure:
                    Color.gray
                        .frame(width: width, height: height)
                        .cornerRadius(cornerRadius)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Color.gray
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
        }
    }
}
