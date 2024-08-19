//
//  MoviesUseCaseProtocol.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 19/08/24.
//

protocol MoviesUseCaseProtocol {
    func execute(queryParams: MoviesQueryParams) async throws -> [Movie]
}
