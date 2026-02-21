//
//  MovieDetailScreen.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import AVKit
import SwiftUI

struct MovieDetailScreen: View {
    let movieID: Int
    @StateObject private var viewModel = MovieDetailViewModel()

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }

            if let movie = viewModel.movie {
                VStack(alignment: .leading, spacing: 16) {
                    if let posterPath = movie.posterPath {
                        AsyncImage(
                            url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                        ) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                    }

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
        .task {
            await viewModel.fetchDetails(movieID: movieID)
        }
    }
}
