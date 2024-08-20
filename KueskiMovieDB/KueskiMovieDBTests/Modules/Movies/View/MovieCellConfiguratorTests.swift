//
//  MovieCellConfiguratorTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MovieCellConfiguratorTests: XCTestCase {

    var configurator: MovieCellConfigurator!
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        configurator = MovieCellConfigurator()
        movie = Movie(
            adult: false,
            backdropPath: "backdrop.jpg",
            genreIds: [.action],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Original Title",
            overview: "Movie overview",
            popularity: 7.5,
            posterPath: "poster.jpg",
            releaseDate: "2024-08-20",
            title: "Movie Title",
            video: false,
            voteAverage: 8.0,
            voteCount: 100
        )
    }
    
    func testConfigureMovieGridCollectionViewCell() {
        let cell = MovieGridCollectionViewCell()
        configurator.configureCell(cell, with: movie)
        
        // Verifica que la celda esté configurada correctamente
        XCTAssertEqual(cell.movieTitleLabel.text, movie.title)
        XCTAssertEqual(cell.movieOverviewLabel.text, movie.overview)
        // Agrega más aserciones según las configuraciones esperadas
    }
    
    func testConfigureMovieListCollectionViewCell() {
        let cell = MovieListCollectionViewCell()
        configurator.configureCell(cell, with: movie)
        
        // Verifica que la celda esté configurada correctamente
        XCTAssertEqual(cell.movieTitleLabel.text, movie.title)
        XCTAssertEqual(cell.movieOverviewLabel.text, movie.overview)
        // Agrega más aserciones según las configuraciones esperadas
    }
}

// Extiende las celdas para permitir la inspección en pruebas
extension MovieGridCollectionViewCell {
    func configureCell(model: Movie) {
        movieTitleLabel.text = model.title
        generalMovieInfoLabel.text = "\(model.releaseDate) • \(model.originalLanguage.uppercased())"
        movieOverviewLabel.text = model.overview
    }
}

extension MovieListCollectionViewCell {
    func configureCell(model: Movie) {
        // Agrega aquí tu lógica de configuración para pruebas
    }
}
