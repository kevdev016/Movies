//
//  MovieListScreen.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation
import SwiftUI

struct MovieListScreen: View {
    @StateObject private var viewModel = MovieListingViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.movies) { movie in
                    Text(movie.title)
                }
                .navigationTitle("Trending")
            }
        }
        .task {
            await viewModel.fetchTrending()
        }
    }
}
