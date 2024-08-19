//
//  PopularMoviesListUseCaseTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class PopularMoviesListUseCaseTests: XCTestCase {

    func testExecuteReturnsMovies() async throws {
        // Arrange
        let mockRepository = MockAsyncRepository()
        let movies = [
            Movie(adult: false, backdropPath: "/path1", genreIds: [.action], id: 1, originalLanguage: "en", originalTitle: "Title 1", overview: "Overview 1", popularity: 100.0, posterPath: "/poster1", releaseDate: "2024-08-19", title: "Movie 1", video: false, voteAverage: 8.5, voteCount: 100),
            Movie(adult: false, backdropPath: "/path2", genreIds: [.adventure], id: 2, originalLanguage: "en", originalTitle: "Title 2", overview: "Overview 2", popularity: 200.0, posterPath: "/poster2", releaseDate: "2024-08-19", title: "Movie 2", video: false, voteAverage: 7.5, voteCount: 150)
        ]
        mockRepository.mockResponse = MovieResponse(results: movies)
        
        let useCase = PopularMoviesListUseCase(apiClient: mockRepository)
        let queryParams = MoviesQueryParams(popularMovies: 1)

        // Act
        let result = try await useCase.execute(queryParams: queryParams)

        // Assert
        XCTAssertEqual(result.count, movies.count)
        XCTAssertEqual(result, movies)
    }

    func testExecuteThrowsError() async {
        // Arrange
        let mockRepository = MockAsyncRepository()
        mockRepository.shouldThrowError = true
        
        let useCase = PopularMoviesListUseCase(apiClient: mockRepository)
        let queryParams = MoviesQueryParams(popularMovies: 1)

        // Act & Assert
        do {
            _ = try await useCase.execute(queryParams: queryParams)
            XCTFail("Expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as NSError).domain, "MockError")
        }
    }
}
