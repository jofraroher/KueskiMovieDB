//
//  MovieDetailPresenter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import Combine

final class MovieDetailPresenter: ObservableObject {
    
    @Published var viewModel: MovieDetailViewModel
    
    private let movieStorageService: MovieStorageServiceProtocol
    
    init(
        viewModel: MovieDetailViewModel,
        movieStorageService: MovieStorageServiceProtocol
    ) {
        self.viewModel = viewModel
        self.movieStorageService = movieStorageService
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    func saveMovie(completion: @escaping (Error?) -> Void) {
        Task {
            do {
                if viewModel.movie.isFavorite {
                    try await movieStorageService.deleteMovie(model: viewModel.movie)
                } else {
                    try await movieStorageService.saveMovie(model: viewModel.movie)
                }
                await updateMovieFavoriteStatus()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    @MainActor private func updateMovieFavoriteStatus() {
        viewModel.movie.isFavorite.toggle()
    }
}
