//
//  MockMovieFetchService.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

class MockMovieStorageService: MovieStorageServiceProtocol {
    var saveMovieCalled = false
    var deleteMovieCalled = false
    var saveMovieModel: Movie?
    var deleteMovieModel: Movie?
    var saveMovieError: Error?
    var deleteMovieError: Error?

    func saveMovie(model: Movie) async throws {
        saveMovieCalled = true
        saveMovieModel = model
        if let error = saveMovieError {
            throw error
        }
    }
    
    func deleteMovie(model: Movie) async throws {
        deleteMovieCalled = true
        deleteMovieModel = model
        if let error = deleteMovieError {
            throw error
        }
    }
}
