//
//  DefaultAPIClientErrorMapperTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

class DefaultAPIClientErrorMapperTests: XCTestCase {
    var errorMapper: DefaultAPIClientErrorMapper!

    override func setUp() {
        super.setUp()
        errorMapper = DefaultAPIClientErrorMapper()
    }

    // Helper function to create a mock error mapper
    private func createMockMapper(withError error: Error?) -> MockRequestErrorMapper {
        let mockMapper = MockRequestErrorMapper()
        mockMapper.mapResponseData = error
        return mockMapper
    }

    func testMapErrorWithValidMapperAndMovieDBError() {
        // Arrange
        let expectedError = KueskiMovieRequestError.customError("Test Error")
        let responseData = "Test Response".data(using: .utf8)
        let mockMapper = createMockMapper(withError: expectedError)
        
        let errorWrapper = APIClientErrorWrapper(error: KueskiMovieRequestError.invalidResponse, responseData: responseData)
        
        // Act
        let result = errorMapper.mapError(error: errorWrapper, requestErrorMapper: mockMapper)
        
        // Assert
        XCTAssertEqual(result as? KueskiMovieRequestError, expectedError, "Expected \(expectedError) but got \(result)")
    }

    func testMapErrorWithNoMapper() {
        // Arrange
        let originalError = KueskiMovieRequestError.invalidResponse
        let errorWrapper = APIClientErrorWrapper(error: originalError, responseData: nil)
        
        // Act
        let result = errorMapper.mapError(error: errorWrapper, requestErrorMapper: nil)
        
        // Assert
        XCTAssertEqual(result as? KueskiMovieRequestError, originalError, "Expected \(originalError) but got \(result)")
    }

    func testMapErrorWithMapperReturningNil() {
        // Arrange
        let originalError = KueskiMovieRequestError.invalidResponse
        let responseData = "Error Response".data(using: .utf8)
        let mockMapper = createMockMapper(withError: nil)
        
        let errorWrapper = APIClientErrorWrapper(error: originalError, responseData: responseData)
        
        // Act
        let result = errorMapper.mapError(error: errorWrapper, requestErrorMapper: mockMapper)
        
        // Assert
        XCTAssertEqual(result as? KueskiMovieRequestError, originalError, "Expected \(originalError) but got \(result)")
    }
    
    func testMapErrorWithInvalidResponseData() {
        // Arrange
        let originalError = KueskiMovieRequestError.invalidResponse
        let responseData = Data() // Invalid or unexpected data
        let mockMapper = createMockMapper(withError: nil)
        
        let errorWrapper = APIClientErrorWrapper(error: originalError, responseData: responseData)
        
        // Act
        let result = errorMapper.mapError(error: errorWrapper, requestErrorMapper: mockMapper)
        
        // Assert
        XCTAssertEqual(result as? KueskiMovieRequestError, originalError, "Expected \(originalError) but got \(result)")
    }
}
