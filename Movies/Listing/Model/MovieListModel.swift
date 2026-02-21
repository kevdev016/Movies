//
//  MovieListModel.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Identifiable, Decodable {
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
}
