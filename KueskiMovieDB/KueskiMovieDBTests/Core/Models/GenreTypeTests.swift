//
//  GenreTypeTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class GenreTypeTests: XCTestCase {

    func testGenreTypeInitializationFromRawValue() {
        XCTAssertEqual(GenreType(rawValue: 28), .action)
        XCTAssertEqual(GenreType(rawValue: 12), .adventure)
        XCTAssertEqual(GenreType(rawValue: 16), .animation)
        XCTAssertEqual(GenreType(rawValue: 35), .comedy)
        XCTAssertEqual(GenreType(rawValue: 80), .crime)
        XCTAssertEqual(GenreType(rawValue: 99), .documentary)
        XCTAssertEqual(GenreType(rawValue: 18), .drama)
        XCTAssertEqual(GenreType(rawValue: 10751), .family)
        XCTAssertEqual(GenreType(rawValue: 14), .fantasy)
        XCTAssertEqual(GenreType(rawValue: 36), .history)
        XCTAssertEqual(GenreType(rawValue: 27), .horror)
        XCTAssertEqual(GenreType(rawValue: 10402), .music)
        XCTAssertEqual(GenreType(rawValue: 9648), .mystery)
        XCTAssertEqual(GenreType(rawValue: 10749), .romance)
        XCTAssertEqual(GenreType(rawValue: 878), .scienceFiction)
        XCTAssertEqual(GenreType(rawValue: 10770), .tvMovie)
        XCTAssertEqual(GenreType(rawValue: 53), .thriller)
        XCTAssertEqual(GenreType(rawValue: 10752), .war)
        XCTAssertEqual(GenreType(rawValue: 37), .western)
        XCTAssertNil(GenreType(rawValue: 999))
    }

    func testGenreTypeGenreName() {
        XCTAssertEqual(GenreType.action.genreName, "Action")
        XCTAssertEqual(GenreType.adventure.genreName, "Adventure")
        XCTAssertEqual(GenreType.animation.genreName, "Animation")
        XCTAssertEqual(GenreType.comedy.genreName, "Comedy")
        XCTAssertEqual(GenreType.crime.genreName, "Crime")
        XCTAssertEqual(GenreType.documentary.genreName, "Documentary")
        XCTAssertEqual(GenreType.drama.genreName, "Drama")
        XCTAssertEqual(GenreType.family.genreName, "Family")
        XCTAssertEqual(GenreType.fantasy.genreName, "Fantasy")
        XCTAssertEqual(GenreType.history.genreName, "History")
        XCTAssertEqual(GenreType.horror.genreName, "Horror")
        XCTAssertEqual(GenreType.music.genreName, "Music")
        XCTAssertEqual(GenreType.mystery.genreName, "Mystery")
        XCTAssertEqual(GenreType.romance.genreName, "Romance")
        XCTAssertEqual(GenreType.scienceFiction.genreName, "Science Fiction")
        XCTAssertEqual(GenreType.tvMovie.genreName, "TV Movie")
        XCTAssertEqual(GenreType.thriller.genreName, "Thriller")
        XCTAssertEqual(GenreType.war.genreName, "War")
        XCTAssertEqual(GenreType.western.genreName, "Western")
        XCTAssertEqual(GenreType.notFound.genreName, "Not Found")
    }

    func testGenreTypeEncoding() throws {
        let encoder = JSONEncoder()
        
        let genre = GenreType.action
        let data = try encoder.encode(genre)
        let jsonString = String(data: data, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "28")
    }
}
