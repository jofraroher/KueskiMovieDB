//
//  MovieDetailPresenter.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import Combine

final class MovieDetailPresenter {
    
    @Published var viewModel: MovieDetailViewModel
    
    internal let movieStorageService: MovieStorageServiceProtocol
    
    init(
        viewModel: MovieDetailViewModel,
        movieStorageService: MovieStorageServiceProtocol
    ) {
        self.viewModel = viewModel
        self.movieStorageService = movieStorageService
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol { 
    
    func saveMovie() {
        Task {
            do {
                if viewModel.movie.isFavorite {
                    try await movieStorageService.deleteMovie(model: viewModel.movie)
                    await publishChanges()
                } else {
                    try await movieStorageService.saveMovie(model: viewModel.movie)
                    await publishChanges()
                }
            } catch {
                // await updateUI(with: items, append: false)
                // await handleError(error)
            }
        }
    }
    
    @MainActor func publishChanges() {
        viewModel.movie.isFavorite.toggle()
    }
}
