//
//  MovieGridCollectionViewCellTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieGridCollectionViewCellTests: XCTestCase {

    var cell: MovieGridCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = MovieGridCollectionViewCell(frame: .zero)
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testConfigureCell_setsUpLabelsCorrectly() {
        let movie = Movie(
            adult: false,
            backdropPath: "/testBackdrop.jpg",
            genreIds: [.action, .drama],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "This is a test movie.",
            popularity: 100.0,
            posterPath: "/testPoster.jpg",
            releaseDate: "2024-08-20",
            title: "Test Movie",
            video: false,
            voteAverage: 8.5,
            voteCount: 1000,
            isFavorite: true
        )

        cell.configureCell(model: movie)

        XCTAssertEqual(cell.movieTitleLabel.text, "Test Movie")
        XCTAssertEqual(cell.generalMovieInfoLabel.text, "2024-08-20 • EN")
        XCTAssertEqual(cell.movieOverviewLabel.text, "This is a test movie.")
    }

    func testConfigurePosterImageView_withValidPath() {
        let movie = Movie(
            adult: false,
            backdropPath: "/testBackdrop.jpg",
            genreIds: [.action],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "This is a test movie.",
            popularity: 100.0,
            posterPath: "/validPosterPath.jpg",
            releaseDate: "2024-08-20",
            title: "Test Movie",
            video: false,
            voteAverage: 8.5,
            voteCount: 1000,
            isFavorite: false
        )

        cell.configureCell(model: movie)

        XCTAssertEqual(cell.posterImageView.image, UIImage(named: "validPosterPath"))
    }

    func testConfigurePosterImageView_withInvalidPath() {
        let movie = Movie(
            adult: false,
            backdropPath: "/testBackdrop.jpg",
            genreIds: [.action],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "This is a test movie.",
            popularity: 100.0,
            posterPath: "/invalidPosterPath.jpg",
            releaseDate: "2024-08-20",
            title: "Test Movie",
            video: false,
            voteAverage: 8.5,
            voteCount: 1000,
            isFavorite: false
        )

        cell.configureCell(model: movie)

        XCTAssertEqual(cell.posterImageView.image, nil)
    }
}
