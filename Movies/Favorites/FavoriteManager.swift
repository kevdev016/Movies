//
//  FavoriteManager.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Combine
import Foundation

@MainActor
class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: Set<Movie> = []

    private let favoritesKey = "favoriteMovies"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadFavorites()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(movie)
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            favorites.remove(movie)
        } else {
            favorites.insert(movie)
        }
        saveFavorites()
    }

    private func loadFavorites() {
        guard let data = userDefaults.data(forKey: favoritesKey) else {
            favorites = []
            return
        }

        do {
            favorites = try JSONDecoder().decode(Set<Movie>.self, from: data)
        } catch {
            print("Failed to decode favorites:", error)
            favorites = []
        }
    }

    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favorites)
            userDefaults.set(data, forKey: favoritesKey)
        } catch {
            print("Failed to save favorites:", error)
        }
    }
}
