//
//  MoreDetailView.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

struct MoreDetailView<ViewModel: MoreDetailViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            rowView(title: AppString.genre, value: viewModel.genreText)
            Divider()
            rowView(title: AppString.runtime, value: viewModel.runtimeText)
            Divider()
            rowView(title: AppString.actors, value: viewModel.actorsText)
            Divider()
            rowView(title: AppString.director, value: viewModel.directorText)

            Spacer()

            VStack(spacing: 16) {
                Button(action: { viewModel.backTapped() }) {
                    Text(AppString.back).frame(maxWidth: .infinity)
                        .font(.montserrat(.bold, size: 16))
                }

                Button(action: { viewModel.backToHomeTapped() }) {
                    Text(AppString.navigateToHome).frame(maxWidth: .infinity)
                        .font(.montserrat(.bold, size: 16))
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
                .font(.montserrat(.semiBold, size: 16))
                .fixedSize()
            Spacer(minLength: 4)
            Text(value)
                .font(.montserrat(.light, size: 16))
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 8)
    }
}
