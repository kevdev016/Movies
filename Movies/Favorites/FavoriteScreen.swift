//
//  FavoriteScreen.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import SwiftUI

struct FavoritesScreen: View {
    
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Array(favoritesManager.favorites)) { movie in
                        MovieListingCard(movie: movie)
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
        }
    }
}
