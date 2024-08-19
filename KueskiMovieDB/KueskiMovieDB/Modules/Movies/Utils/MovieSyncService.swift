//
//  MovieSyncService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol MovieSyncServiceProtocol {
    func syncWithSavedMovies(newItems: [Movie], fetchingService: MovieFetchingServiceProtocol) async throws -> [Movie]
}

final class MovieSyncService: MovieSyncServiceProtocol {
    func syncWithSavedMovies(newItems: [Movie], fetchingService: MovieFetchingServiceProtocol) async throws -> [Movie] {
        let savedItems = try await fetchingService.getSavedMovies()
        let savedItemIDs = Set(savedItems.map { $0.id })
        
        let updatedItems = newItems.map { movie -> Movie in
            var updatedMovie = movie
            if savedItemIDs.contains(movie.id) {
                updatedMovie.isFavorite = true
            } else {
                updatedMovie.isFavorite = false
            }
            return updatedMovie
        }
        
        return updatedItems
    }
}
