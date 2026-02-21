//
//  MoviesDetails.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
    let voteAverage: Double
    let genres: [Genre]
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let type: String
    let site: String
}
