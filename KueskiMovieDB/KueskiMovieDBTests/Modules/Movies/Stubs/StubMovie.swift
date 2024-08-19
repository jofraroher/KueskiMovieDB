//
//  StubMovie.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

enum StubMovie {
    
    static func getStubMovie(isFavorite: Bool = false) -> Movie {
        Movie(
            adult: false,
            backdropPath: "Test",
            genreIds: [.action],
            id: 1,
            originalLanguage: "Test",
            originalTitle: "Test",
            overview: "Test",
            popularity: 1.0,
            posterPath: "Test",
            releaseDate: "Test",
            title: "Test",
            video: false,
            voteAverage: 1.0,
            voteCount: 1.0,
            isFavorite: isFavorite
        )
    }
}
