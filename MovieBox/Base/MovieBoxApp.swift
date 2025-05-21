//
//  MovieBoxApp.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

@main
struct MovieBoxApp: App {
    let networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(networkManager: networkManager), networkManager: networkManager)
        }
    }
}
