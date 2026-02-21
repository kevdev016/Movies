//
//  MovieListModel.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let rating: Double
    let posterPath: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rating = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "\(APIConfig.imageBaseURL)/w500\(posterPath)")
    }
}
