//
//  ConfigurationTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class ConfigurationTests: XCTestCase {
    
    func testGetConfigurationValue_withValidKey_returnsExpectedValue() {
        // Arrange
        let bundle = StringTable.KueskiMovieDB
        let key = MoviesBaseConfiguration.baseMovieDBPath
        let expectedValue = "/discover/movie"
        
        // Act
        let result: String? = Configuration.getConfigurationValue(valueType: String.self, key: key, bundle: bundle)
        
        // Assert
        XCTAssertTrue(result?.contains(expectedValue) ?? false)
    }
    
    func testGetConfigurationValue_withInvalidKey_returnsNil() {
        // Arrange
        let bundle = StringTable.KueskiMovieDB
        let key = MoviesBaseConfiguration.invalidKey
        
        // Act
        let result: String? = Configuration.getConfigurationValue(valueType: String.self, key: key, bundle: bundle)
        
        // Assert
        XCTAssertNil(result, "getConfigurationValue should return nil for an invalid key")
    }
    
    func testGetConfigurationDictionary_withValidBundle_returnsDictionary() {
        // Arrange
        let bundle = StringTable.KueskiMovieDB
        
        // Act
        let result = Configuration.getConfigurationDictionary(bundle: bundle)
        
        // Assert
        XCTAssertNotNil(result, "getConfigurationDictionary should return a dictionary for a valid bundle")
    }
    
    func testGetConfigurationDictionary_withInvalidBundle_returnsNil() {
        // Arrange
        let bundle = StringTable.InvalidBundle
        
        // Act
        let result = Configuration.getConfigurationDictionary(bundle: bundle)
        
        // Assert
        XCTAssertNil(result, "getConfigurationDictionary should return nil for an invalid bundle")
    }
    
    func testGetConfigurationPath_returnsCorrectPath() {
        // Arrange
        let bundle = StringTable.KueskiMovieDB
        let expectedPath = bundle.rawValue + ResourceType.Configuration.rawValue
        
        // Act
        let result = Configuration.getConfigurationPath(bundle: bundle)
        
        // Assert
        XCTAssertEqual(result, expectedPath, "getConfigurationPath should return the correct path")
    }
    
}
