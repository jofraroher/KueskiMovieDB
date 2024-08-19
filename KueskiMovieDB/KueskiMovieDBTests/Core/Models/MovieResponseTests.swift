//
//  MovieResponseTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieResponseTests: XCTestCase {

    func testMovieResponseDecoding() throws {
        let json = """
        {
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/path/to/backdrop.jpg",
                    "genre_ids": [28, 12],
                    "id": 12345,
                    "original_language": "en",
                    "original_title": "Original Title",
                    "overview": "This is an overview.",
                    "popularity": 1000.0,
                    "poster_path": "/path/to/poster.jpg",
                    "release_date": "2024-08-19",
                    "title": "Movie Title",
                    "video": false,
                    "vote_average": 8.5,
                    "vote_count": 100
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let movieResponse = try decoder.decode(MovieResponse.self, from: json)
        
        XCTAssertEqual(movieResponse.results.count, 1)
        
        let movie = movieResponse.results.first
        XCTAssertEqual(movie?.adult, false)
        XCTAssertEqual(movie?.backdropPath, "/path/to/backdrop.jpg")
        XCTAssertEqual(movie?.genreIds, [.action, .adventure])
        XCTAssertEqual(movie?.id, 12345)
        XCTAssertEqual(movie?.originalLanguage, "en")
        XCTAssertEqual(movie?.originalTitle, "Original Title")
        XCTAssertEqual(movie?.overview, "This is an overview.")
        XCTAssertEqual(movie?.popularity, 1000.0)
        XCTAssertEqual(movie?.posterPath, "/path/to/poster.jpg")
        XCTAssertEqual(movie?.releaseDate, "2024-08-19")
        XCTAssertEqual(movie?.title, "Movie Title")
        XCTAssertEqual(movie?.video, false)
        XCTAssertEqual(movie?.voteAverage, 8.5)
        XCTAssertEqual(movie?.voteCount, 100)
    }
    
    func testMovieResponseEncoding() throws {
        let movie = Movie(
            adult: false,
            backdropPath: "/path/to/backdrop.jpg",
            genreIds: [.action, .adventure],
            id: 12345,
            originalLanguage: "en",
            originalTitle: "Original Title",
            overview: "This is an overview.",
            popularity: 1000.0,
            posterPath: "/path/to/poster.jpg",
            releaseDate: "2024-08-19",
            title: "Movie Title",
            video: false,
            voteAverage: 8.5,
            voteCount: 100
        )
        
        let movieResponse = MovieResponse(results: [movie])
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(movieResponse)
        let jsonString = String(data: data, encoding: .utf8)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString?.contains("\"adult\":false") ?? false)
        XCTAssertTrue(jsonString?.contains("\"backdrop_path\":\"\\/path\\/to\\/backdrop.jpg\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"genre_ids\":[28,12]") ?? false)
        XCTAssertTrue(jsonString?.contains("\"id\":12345") ?? false)
        XCTAssertTrue(jsonString?.contains("\"original_language\":\"en\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"original_title\":\"Original Title\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"overview\":\"This is an overview.\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"popularity\":1000") ?? false)
        XCTAssertTrue(jsonString?.contains("\"poster_path\":\"\\/path\\/to\\/poster.jpg\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"release_date\":\"2024-08-19\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"title\":\"Movie Title\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"video\":false") ?? false)
        XCTAssertTrue(jsonString?.contains("\"vote_average\":8.5") ?? false)
        XCTAssertTrue(jsonString?.contains("\"vote_count\":100") ?? false)
    }
}
