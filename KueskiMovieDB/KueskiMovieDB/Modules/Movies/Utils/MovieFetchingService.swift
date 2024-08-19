//
//  MovieStorageService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol MovieFetchingServiceProtocol: AnyObject {
    func getSavedMovies() async throws -> [Movie]
}

final class MovieFetchingService: MovieFetchingServiceProtocol {
    private let fetchingInteractor: MoviesFetchingProtocol
    
    init(fetchingInteractor: MoviesFetchingProtocol ) {
        self.fetchingInteractor = fetchingInteractor
    }
    
    func getSavedMovies() async throws -> [Movie] {
        try await fetchingInteractor.getSavedMovies()
    }
}
