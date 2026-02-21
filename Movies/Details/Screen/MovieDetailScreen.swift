//
//  MovieDetailScreen.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import AVKit
import SwiftUI

struct MovieDetailScreen: View {
    let movie: Movie
    @StateObject private var viewModel = MovieDetailViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }

            if let movie = viewModel.movie {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(
                        url: movie.posterURL != nil
                            ? movie.posterURL
                            : nil
                    ) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Color.gray.opacity(0.2)
                                ProgressView()
                            }

                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFill()

                        case .failure:
                            ZStack {
                                Color.gray.opacity(0.2)

                                VStack(spacing: 8) {
                                    Image(systemName: "film")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)

                                    Text("No Image Available")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }

                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(minHeight: 350)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)

                    Text(movie.title)
                        .font(.title)
                        .foregroundColor(.textPrimary)
                        .bold()

                    Text("⭐️ \(movie.voteAverage, specifier: "%.1f")")
                        .foregroundColor(.textPrimary)

                    if let runtime = movie.runtime {
                        Text("Duration: \(runtime) mins")
                            .foregroundColor(.textPrimary)
                    }

                    Text("Genres: \(movie.genres.map { $0.name }.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.textPrimary)

                    Text(movie.overview)
                        .foregroundColor(.textPrimary)
                        .padding(.top, 8)

                    if let trailerKey = viewModel.trailerKey {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Trailer")
                                .font(.headline)
                                .foregroundColor(.textPrimary)

                            YouTubePlayerView(videoID: trailerKey)
                                .frame(height: 220)
                                .clipShape(RoundedRectangle(cornerRadius: 12))

                            if let youtubeURL = viewModel.youtubeURL {
                                Link(destination: youtubeURL) {
                                    HStack {
                                        Image(systemName: "play.circle.fill")
                                        Text("Watch on YouTube")
                                            .bold()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    favoritesManager.toggleFavorite(movie)
                } label: {
                    Image(systemName: favoritesManager.isFavorite(movie) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }

        .task {
            await viewModel.fetchDetails(movieID: movie.id)
        }
    }
}
