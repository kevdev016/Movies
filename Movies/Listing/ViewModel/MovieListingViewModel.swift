//
//  MovieListingViewModel.swift
//  Movies
//
//  Created by Kevin Jeggy(UST, IN) on 21/02/26.
//

import Combine
import Foundation

@MainActor
class MovieListingViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var isPaginating = false
    @Published var errorMessage: String?

    private var currentSearchTask: Task<Void, Never>?

    private var currentPage = 1
    private var totalPages = 1
    private var currentQuery: String = ""

    func fetchTrending() async {
        resetPagination()
        currentQuery = ""

        isLoading = true
        defer { isLoading = false }

        await fetchMovies()
    }

    func searchMovies(query: String) {
        currentSearchTask?.cancel()

        currentSearchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            if Task.isCancelled { return }

            if query.isEmpty {
                await fetchTrending()
                return
            }

            resetPagination()
            currentQuery = query

            isLoading = true
            defer { isLoading = false }

            await fetchMovies()
        }
    }

    func loadMoreIfNeeded(currentItem movie: Movie) async {
        guard let last = movies.last else { return }

        if movie.id == last.id && currentPage < totalPages && !isPaginating {
            await fetchNextPage()
        }
    }

    private func fetchNextPage() async {
        guard !isPaginating else { return }

        isPaginating = true
        currentPage += 1

        await fetchMovies(isPagination: true)

        isPaginating = false
    }

    private func fetchMovies(isPagination: Bool = false) async {
        do {
            let response: MovieResponse

            if currentQuery.isEmpty {
                response = try await NetworkService.shared.request(
                    .popular(page: currentPage)
                )
            } else {
                response = try await NetworkService.shared.request(
                    .search(query: currentQuery, page: currentPage)
                )
            }

            totalPages = response.totalPages

            if isPagination {
                movies.append(contentsOf: response.results)
            } else {
                movies = response.results
            }

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func resetPagination() {
        currentPage = 1
        totalPages = 1
        movies = []
    }
}
