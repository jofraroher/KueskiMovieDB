//
//  MovieTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
import CoreData
@testable import KueskiMovieDB

final class MovieTests: XCTestCase {
    
    func testMovieDecoding() throws {
        let json = """
        {
            "adult": false,
            "backdrop_path": "/path/to/backdrop.jpg",
            "genre_ids": [28, 12, 16],
            "id": 123,
            "original_language": "en",
            "original_title": "Test Movie",
            "overview": "This is a test movie.",
            "popularity": 100.0,
            "poster_path": "/path/to/poster.jpg",
            "release_date": "2024-08-19",
            "title": "Test Movie",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 1000
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let movie = try decoder.decode(Movie.self, from: json)
        
        XCTAssertEqual(movie.adult, false)
        XCTAssertEqual(movie.backdropPath, "/path/to/backdrop.jpg")
        XCTAssertEqual(movie.genreIds, [.action, .adventure, .animation])
        XCTAssertEqual(movie.id, 123)
        XCTAssertEqual(movie.originalLanguage, "en")
        XCTAssertEqual(movie.originalTitle, "Test Movie")
        XCTAssertEqual(movie.overview, "This is a test movie.")
        XCTAssertEqual(movie.popularity, 100.0)
        XCTAssertEqual(movie.posterPath, "/path/to/poster.jpg")
        XCTAssertEqual(movie.releaseDate, "2024-08-19")
        XCTAssertEqual(movie.title, "Test Movie")
        XCTAssertEqual(movie.video, false)
        XCTAssertEqual(movie.voteAverage, 7.5)
        XCTAssertEqual(movie.voteCount, 1000)
        XCTAssertEqual(movie.isFavorite, false)
    }

    func testMovieEncoding() throws {
        let movie = Movie(
            adult: false,
            backdropPath: "/path/to/backdrop.jpg",
            genreIds: [.action, .adventure, .animation],
            id: 123,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "This is a test movie.",
            popularity: 100.0,
            posterPath: "/path/to/poster.jpg",
            releaseDate: "2024-08-19",
            title: "Test Movie",
            video: false,
            voteAverage: 7.5,
            voteCount: 1000
        )
        
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(movie)
        
        let decoder = JSONDecoder()
        let decodedMovie = try decoder.decode(Movie.self, from: encodedData)
        
        XCTAssertEqual(decodedMovie, movie)
    }

    func testMovieToEntity() throws {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        let movie = Movie(
            adult: false,
            backdropPath: "/path/to/backdrop.jpg",
            genreIds: [.action, .adventure, .animation],
            id: 123,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "This is a test movie.",
            popularity: 100.0,
            posterPath: "/path/to/poster.jpg",
            releaseDate: "2024-08-19",
            title: "Test Movie",
            video: false,
            voteAverage: 7.5,
            voteCount: 1000
        )
        
        let movieEntity = movie.toEntity(context: context)
        
        XCTAssertEqual(movieEntity.adult, false)
        XCTAssertEqual(movieEntity.backdropPath, "/path/to/backdrop.jpg")
        XCTAssertEqual(movieEntity.genreIds as? [Int], [28, 12, 16])
        XCTAssertEqual(movieEntity.id, 123)
        XCTAssertEqual(movieEntity.originalLanguage, "en")
        XCTAssertEqual(movieEntity.originalTitle, "Test Movie")
        XCTAssertEqual(movieEntity.overview, "This is a test movie.")
        XCTAssertEqual(movieEntity.popularity, 100.0)
        XCTAssertEqual(movieEntity.posterPath, "/path/to/poster.jpg")
        XCTAssertEqual(movieEntity.releaseDate, "2024-08-19")
        XCTAssertEqual(movieEntity.title, "Test Movie")
        XCTAssertEqual(movieEntity.video, false)
        XCTAssertEqual(movieEntity.voteAverage, 7.5)
        XCTAssertEqual(movieEntity.voteCount, 1000)
    }

    func testMovieResponseDecoding() throws {
        let json = """
        {
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/path/to/backdrop.jpg",
                    "genre_ids": [28, 12, 16],
                    "id": 123,
                    "original_language": "en",
                    "original_title": "Test Movie",
                    "overview": "This is a test movie.",
                    "popularity": 100.0,
                    "poster_path": "/path/to/poster.jpg",
                    "release_date": "2024-08-19",
                    "title": "Test Movie",
                    "video": false,
                    "vote_average": 7.5,
                    "vote_count": 1000
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let movieResponse = try decoder.decode(MovieResponse.self, from: json)
        
        XCTAssertEqual(movieResponse.results.count, 1)
        XCTAssertEqual(movieResponse.results.first?.id, 123)
    }
    
    func testMovieDecodingWithMissingKeys() throws {
            let json = """
            {
                "id": 123
            }
            """.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            let movie = try decoder.decode(Movie.self, from: json)
            
            XCTAssertEqual(movie.adult, false)
            XCTAssertEqual(movie.backdropPath, "")
            XCTAssertEqual(movie.genreIds, [])
            XCTAssertEqual(movie.id, 123)
            XCTAssertEqual(movie.originalLanguage, "")
            XCTAssertEqual(movie.originalTitle, "")
            XCTAssertEqual(movie.overview, "")
            XCTAssertEqual(movie.popularity, 0.0)
            XCTAssertEqual(movie.posterPath, "")
            XCTAssertEqual(movie.releaseDate, "")
            XCTAssertEqual(movie.title, "")
            XCTAssertEqual(movie.video, false)
            XCTAssertEqual(movie.voteAverage, 0.0)
            XCTAssertEqual(movie.voteCount, 0.0)
            XCTAssertEqual(movie.isFavorite, false)
        }
}
