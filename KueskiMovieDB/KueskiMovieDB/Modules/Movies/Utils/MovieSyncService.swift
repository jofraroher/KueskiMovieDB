//
//  MovieSyncService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol MovieSyncServiceProtocol {
    func syncWithSavedMovies(newItems: [Movie], storageService: MovieStorageServiceProtocol) async throws -> [Movie]
}

final class MovieSyncService: MovieSyncServiceProtocol {
    func syncWithSavedMovies(newItems: [Movie], storageService: MovieStorageServiceProtocol) async throws -> [Movie] {
        let savedItems = try await storageService.getSavedMovies()
        print(savedItems)
        let savedItemIDs = Set(savedItems.map { $0.id })
        
        let updatedItems = newItems.map { movie -> Movie in
            var updatedMovie = movie
            if savedItemIDs.contains(movie.id) {
                updatedMovie.isFavorite = true
            }
            return updatedMovie
        }
        
        return updatedItems
    }
}
