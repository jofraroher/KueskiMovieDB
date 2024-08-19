//
//  MockMoviesView.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

@testable import KueskiMovieDB
import UIKit
import XCTest

final class MockMoviesView: UIViewController, MoviesViewProtocol {
    var reloadDataCalled = false
    var showAlertCalled = false
    var items: [Movie] = []

    var reloadDataExpectation: XCTestExpectation?
    var showAlertExpectation: XCTestExpectation?
    
    func reloadData(items: [Movie]) {
        reloadDataCalled = true
        self.items = items
        reloadDataExpectation?.fulfill()
    }

    func showAlert() {
        showAlertCalled = true
        showAlertExpectation?.fulfill()
    }
}
