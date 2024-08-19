//
//  MockMoviesDatabaseProtocol.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockMoviesDatabaseProtocol: MoviesDatabaseProtocol {
    var deleteMovieCalled = false
    var saveMovieCalled = false
    var deleteMovieError: Error?
    var saveMovieError: Error?
    
    func deleteMovie(model: Movie) async throws {
        deleteMovieCalled = true
        if let error = deleteMovieError {
            throw error
        }
    }
    
    func saveMovie(model: Movie) async throws {
        saveMovieCalled = true
        if let error = saveMovieError {
            throw error
        }
    }
    
    func getSavedMovies() async throws -> [Movie] {
        return []
    }
}
