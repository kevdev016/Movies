//
//  MovieListingCard.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import SwiftUI

struct MovieListingCard: View {
    let movie: Movie
    @EnvironmentObject var favoritesManager: FavoritesManager

    var isFavorite: Bool {
        favoritesManager.isFavorite(movie)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(
                    url: movie.posterPath != nil
                        ? URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath!)")
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
                                    .font(.system(size: 30))
                                    .foregroundColor(.gray)

                                Text("No Image")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }

                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(minHeight: 220)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)

                Button {
                    favoritesManager.toggleFavorite(movie)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)

                if let releaseDate = movie.releaseDate,
                   let year = releaseDate.split(separator: "-").first {
                    Text(String(year))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)

                    Text(String(format: "%.1f", movie.rating))
                        .font(.subheadline)
                        .bold()
                }
            }
        }
        .padding(10)
        .background(Color.backgroundSecondary)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
    }
}
