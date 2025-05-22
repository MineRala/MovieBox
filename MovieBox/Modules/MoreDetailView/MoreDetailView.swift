//
//  MoreDetailView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

// MoreDetailView.swift

import SwiftUI

import SwiftUI

struct MoreDetailView: View {
    @StateObject var viewModel: MoreDetailViewModel

    var body: some View {
        VStack(spacing: 0) {
            rowView(title: "Genre", value: viewModel.genreText)
            Divider()
            rowView(title: "Runtime", value: viewModel.runtimeText)
            Divider()
            rowView(title: "Actors", value: viewModel.actorsText)
            Divider()
            rowView(title: "Director", value: viewModel.directorText)

            Spacer()

            VStack(spacing: 12) {
                Button(action: { viewModel.backTapped() }) {
                    Text("Back").frame(maxWidth: .infinity)
                }

                Button(action: { viewModel.backToHomeTapped() }) {
                    Text("Navigate to Home").frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding([.bottom, .leading, .trailing])
        .background(Color(.systemBackground))
    }

    @ViewBuilder
    private func rowView(title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(title)
                .fontWeight(.semibold)
                .fixedSize()
            Spacer(minLength: 4)
            Text(value)
                .fontWeight(.light)
                .font(.callout)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 8)
    }
}
