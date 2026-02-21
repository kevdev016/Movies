//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    @Published var movie: MovieDetail?
    @Published var trailerURL: URL?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let network: NetworkService
    @Published var trailerKey: String?
    var youtubeURL: URL? {
        guard let key = trailerKey else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
    
    init(network: NetworkService = NetworkService.shared) {
        self.network = network
    }
    
    func fetchDetails(movieID: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let details: MovieDetail = network.request(.movieDetails(id: movieID))
            async let videos: VideoResponse = network.request(.movieVideos(id: movieID))
            
            let (movieDetail, videoResponse) = try await (details, videos)
            
            self.movie = movieDetail
            print(videoResponse.results)
            if let trailer = videoResponse.results.first(where: {
                $0.type == "Trailer" && $0.site == "YouTube"
            }) {
                trailerKey = trailer.key
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
