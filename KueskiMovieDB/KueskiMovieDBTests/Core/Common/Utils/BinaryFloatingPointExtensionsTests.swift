//
//  BinaryFloatingPointExtensionsTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class BinaryFloatingPointExtensionsTests: XCTestCase {
    
    func testFormattedSmallNumber() {
        // Arrange
        let number: Float = 123.456
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "123.46", "Expected formatted string to be '123.46' but got \(formatted)")
    }
    
    func testFormattedThousand() {
        // Arrange
        let number: Float = 1500
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "1.5K", "Expected formatted string to be '1.5K' but got \(formatted)")
    }
    
    func testFormattedMillion() {
        // Arrange
        let number: Float = 2_500_000
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "2.5M", "Expected formatted string to be '2.5M' but got \(formatted)")
    }
    
    func testFormattedBillion() {
        // Arrange
        let number: Float = 3_500_000_000
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "3.5B", "Expected formatted string to be '3.5B' but got \(formatted)")
    }
    
    func testFormattedZero() {
        // Arrange
        let number: Float = 0
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "0", "Expected formatted string to be '0' but got \(formatted)")
    }
    
    func testFormattedNegativeNumber() {
        // Arrange
        let number: Float = -123456
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "-123.5K", "Expected formatted string to be '-123.5K' but got \(formatted)")
    }
    
    func testFormattedDouble() {
        // Arrange
        let number: Double = 987_654_321.123
        
        // Act
        let formatted = number.formatted
        
        // Assert
        XCTAssertEqual(formatted, "987.7M", "Expected formatted string to be '987.7M' but got \(formatted)")
    }
}
