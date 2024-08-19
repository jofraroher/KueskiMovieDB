//
//  MockMoviesRouter.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB

final class MockMoviesRouter: MoviesRouterProtocol {
    var navigateToMovieDetailCalled = false

    func navigateToMovieDetail() {
        navigateToMovieDetailCalled = true
    }
}
