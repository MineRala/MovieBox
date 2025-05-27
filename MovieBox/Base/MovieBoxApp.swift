//
//  MovieBoxApp.swift
//  MovieBox
//
//  Created by Mine Rala on 21.05.2025.
//

import SwiftUI

@main
struct MovieBoxApp: App {
    @StateObject private var coordinator = MovieCoordinator(networkManager: NetworkManager())

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
