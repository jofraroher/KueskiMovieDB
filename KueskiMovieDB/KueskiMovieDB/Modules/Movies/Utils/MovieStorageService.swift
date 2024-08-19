//
//  MovieStorageService.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol MovieStorageServiceProtocol: AnyObject {
    func saveMovie(model: Movie) async throws
    func getSavedMovies() async throws -> [Movie]
    func deleteMovie(model: Movie) async throws
}

final class MovieStorageService: MovieStorageServiceProtocol {
    private let interactor: MoviesInteractorProtocol
    
    init(interactor: MoviesInteractorProtocol) {
        self.interactor = interactor
    }
    
    func saveMovie(model: Movie) async throws {
        if !model.isFavorite {
            try await interactor.saveMovie(model: model)
        }
    }
    
    func getSavedMovies() async throws -> [Movie] {
        try await interactor.getSavedMovies()
    }
    
    func deleteMovie(model: Movie) async throws {
        try await interactor.deleteMovie(model: model)
    }
}
