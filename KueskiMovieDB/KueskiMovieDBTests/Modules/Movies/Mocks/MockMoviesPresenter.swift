//
//  MockMoviesPresenter.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockMoviesPresenter: MoviesPresenterProtocol {
    
    var items: [Movie] = []
    var updateMovieListCalled = false
    var sortBy: SortByType?
    
    func updateMovieList() {
        updateMovieListCalled = true
    }
    
    func updateMovieListBySort(sortBy: SortByType) {
        self.sortBy = sortBy
    }
    
    func navigateToMovieDetail(model: Movie) { }
    
    func refreshStatu() { }
}
