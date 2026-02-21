//
//  MovieListingCard.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import SwiftUI

struct MovieListingCard: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let posterPath = movie.posterPath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                ) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.2)
                        ProgressView()
                    }
                }
                .clipped()
                .cornerRadius(12)
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
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
    }
}
