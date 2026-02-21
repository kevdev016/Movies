//
//  Endpoint.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

enum Endpoint: EndpointProtocol {
    // MARK: - Cases

    case popular(page: Int)
    case movieDetails(id: Int)
    case movieVideos(id: Int)
    case search(query: String, page: Int)

    // MARK: - Path

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"

        case let .movieDetails(id):
            return "/movie/\(id)"

        case let .movieVideos(id):
            return "/movie/\(id)/videos"

        case .search:
            return "/search/movie"
        }
    }

    // MARK: - Method

    var method: HTTPMethod {
        return .get
    }

    // MARK: - Query Items

    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "api_key", value: APIConfig.apiKey),
        ]

        switch self {
        case let .popular(page):
            items.append(URLQueryItem(name: "page", value: "\(page)"))

        case let .search(query, page):
            items.append(URLQueryItem(name: "query", value: query))
            items.append(URLQueryItem(name: "page", value: "\(page)"))

        default:
            break
        }

        return items
    }

    // MARK: - URL Builder

    var url: URL? {
        var components = URLComponents(string: APIConfig.baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
