//
//  APIError.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError
}
