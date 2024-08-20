//
//  APIClientAuthorizationTypeTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class APIClientAuthorizationTypeTests: XCTestCase {

    func testBearerTokenAuthorizationHeader() {
        // Arrange
        let token = "testToken"
        let expectedHeader = ["Authorization": "Bearer \(token)"]
        let authType = APIClientAuthorizationType.bearerToken
        
        // Act
        let result = authType.authorizationHeader(token: token)
        
        // Assert
        XCTAssertEqual(result, expectedHeader, "Expected \(expectedHeader) but got \(result)")
    }
    
    func testAuthorizationAuthorizationHeader() {
        // Arrange
        let token = "testToken"
        let expectedHeader = ["Authorization": token]
        let authType = APIClientAuthorizationType.authorization
        
        // Act
        let result = authType.authorizationHeader(token: token)
        
        // Assert
        XCTAssertEqual(result, expectedHeader, "Expected \(expectedHeader) but got \(result)")
    }
    
    func testNoneAuthorizationHeader() {
        // Arrange
        let token = "testToken"
        let expectedHeader: [String: String] = [:]
        let authType = APIClientAuthorizationType.none
        
        // Act
        let result = authType.authorizationHeader(token: token)
        
        // Assert
        XCTAssertEqual(result, expectedHeader, "Expected \(expectedHeader) but got \(result)")
    }
}
