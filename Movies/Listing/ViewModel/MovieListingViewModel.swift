//
//  MovieListingViewModel.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation
import Combine

class MovieListingViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchTrending() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response: MovieResponse = try await NetworkService.shared.request(.popular(page: 1))
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
