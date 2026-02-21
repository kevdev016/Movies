//
//  MovieListScreen.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import SwiftUI

struct MovieListScreen: View {
    @StateObject private var viewModel = MovieListingViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.movies) { movie in

                                NavigationLink {
                                    MovieDetailScreen(movieID: movie.id)
                                } label: {
                                    MovieListingCard(movie: movie)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Popular Movies")
        }
        .task {
            await viewModel.fetchTrending()
        }
    }
}
