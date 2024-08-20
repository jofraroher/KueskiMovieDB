//
//  MovieDetailFactoryTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
import SwiftUI

@testable import KueskiMovieDB

final class MovieDetailFactoryTests: XCTestCase {
    
    func testMovieDetailFactory_build_createsUIViewController() {
        // Arrange
        let movie = StubMovie.getStubMovie()
        
        // Act
        let viewController = MovieDetailFactory.build(model: movie)
        
        // Assert
        XCTAssertTrue(viewController is UIHostingController<MovieDetailView<MovieDetailPresenter>>)
    }
}
