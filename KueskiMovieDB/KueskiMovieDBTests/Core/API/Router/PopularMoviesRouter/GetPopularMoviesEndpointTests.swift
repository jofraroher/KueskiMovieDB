//
//  GetPopularMoviesEndpointTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class GetPopularMoviesEndpointTests: XCTestCase {
    
    func testURLConstruction() {
        // Arrange
        let queryParams: [String: Any] = ["page": 1, "language": "en"]
        let endpoint = GetPopularMoviesEndpoint(queryParams: queryParams)
        
        // Act
        let url = endpoint.url
        
        // Assert
        let expectedBaseURL = String.getConfigurationValue(
            key: MoviesBaseConfiguration.baseMovieDBPath,
            bundle: .KueskiMovieDB
        )
        var expectedComponents = URLComponents(string: expectedBaseURL)
        
        // Ordenar los query items en el orden que esperas
        expectedComponents?.queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "language", value: "en")
        ].sorted { $0.name < $1.name }
        
        // Ordenar los query items en la URL generada para compararla
        let actualComponents = URLComponents(url: url ?? URL(string: "")!, resolvingAgainstBaseURL: false)
        let actualQueryItems = actualComponents?.queryItems?.sorted { $0.name < $1.name }
        
        XCTAssertEqual(actualQueryItems, expectedComponents?.queryItems, "URL was not constructed correctly.")
    }
}
