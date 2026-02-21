//
//  MoviesApp.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            MovieListScreen()
                .environmentObject(favoritesManager)
        }
    }
}
