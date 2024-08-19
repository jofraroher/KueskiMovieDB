//
//  MockMoviesUseCase.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockMoviesUseCase: MoviesUseCaseProtocol {
    var executeCalled = false
    var executeResult: [Movie] = []
    var executeError: Error?

    func execute(queryParams: MoviesQueryParams) async throws -> [Movie] {
        executeCalled = true
        if let error = executeError {
            throw error
        }
        return executeResult
    }
}
