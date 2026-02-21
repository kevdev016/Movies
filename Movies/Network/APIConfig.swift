//
//  APIConfig.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation

enum APIConfig {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String ?? ""
    static let baseURL = "https://api.themoviedb.org/3"
}
