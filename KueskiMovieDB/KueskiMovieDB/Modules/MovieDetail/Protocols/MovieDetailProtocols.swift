//
//  MovieDetailProtocols.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

import Combine

protocol MovieDetailPresenterProtocol: ObservableObject {
    
    var viewModel: MovieDetailViewModel { get set }
    
    func saveMovie()
}

protocol MovieDetailInteractorProtocol: AnyObject {
    func saveMovie(model: Movie) async throws
    func deleteMovie(model: Movie) async throws
}
