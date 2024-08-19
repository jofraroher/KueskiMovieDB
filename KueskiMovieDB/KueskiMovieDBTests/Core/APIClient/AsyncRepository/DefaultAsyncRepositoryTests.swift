//
//  DefaultAsyncRepositoryTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class DefaultAsyncRepositoryTests: XCTestCase {
    private var repository: DefaultAsyncRepository!
    private var mockAPIClient: MockAPIClient!
    private var mockTokenProvider: MockAuthorizationTokenProvider!
    private var mockErrorMapper: MockAPIResponseErrorMapper!

    override func setUp() {
        super.setUp()
        
        mockAPIClient = MockAPIClient()
        mockTokenProvider = MockAuthorizationTokenProvider()
        mockErrorMapper = MockAPIResponseErrorMapper()
        
        repository = DefaultAsyncRepository(
            client: mockAPIClient,
            tokenProvider: mockTokenProvider,
            defaultErrorMapper: mockErrorMapper
        )
    }

    override func tearDown() {
        repository = nil
        mockAPIClient = nil
        mockTokenProvider = nil
        mockErrorMapper = nil
        
        super.tearDown()
    }

    func testRequest_success() async {
        // Arrange
        let expectedData = Data("response".utf8)
        mockAPIClient.processRequestResult = .success(expectedData)
        
        // Act
        let result: Data
        do {
            result = try await repository.requestData(request: APIRequestStub.getAPIRquest(), retries: 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
            return
        }
        
        // Assert
        XCTAssertEqual(result, expectedData)
    }

    func testRequest_failure() async {
        // Arrange
        let expectedError = NSError(domain: "", code: 0, userInfo: nil)
        mockAPIClient.processRequestResult = .failure(APIClientErrorWrapper(error: expectedError, responseData: nil))
        mockErrorMapper.mapErrorResult = expectedError
        
        // Act
        do {
            _ = try await repository.requestData(request: APIRequestStub.getAPIRquest(), retries: 0)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }

    func testAuthorizedRequest_success() async {
        // Arrange
        let expectedData = Data("response".utf8)
        let mockToken = "mockToken"
        mockAPIClient.processRequestResult = .success(expectedData)
        mockTokenProvider.authorizationTokenResult = mockToken
        
        // Act
        let request = APIRequestStub.getAPIRquest()
        let result: Data
        do {
            result = try await repository.requestData(request: request, retries: 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
            return
        }
        
        // Assert
        XCTAssertEqual(result, expectedData)
    }

    func testAuthorizedRequest_failure() async {
        // Arrange
        let expectedError = NSError(domain: "", code: 0, userInfo: nil)
        mockAPIClient.processRequestResult = .failure(APIClientErrorWrapper(error: expectedError, responseData: nil))
        mockErrorMapper.mapErrorResult = expectedError
        mockTokenProvider.authorizationTokenError = NSError(domain: "", code: 0, userInfo: nil)
        
        
        // Act
        let request = APIRequestStub.getAPIRquest()
        do {
            _ = try await repository.requestData(request: request, retries: 0)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func testEmptyResponseRequest_success() async {
        // Arrange / Act
        let expectedData = Data("response".utf8)
        mockAPIClient.processRequestResult = .success(expectedData)
        let request = APIRequestStub.getAPIRquest(authorizationType: .none)
        let result: Void
        do {
            result = try await repository.emptyResponseRequest(request: request, retries: 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
            return
        }
        // Assert
        XCTAssertNotNil(result)
    }
    
    func testEmptyResponseRequest_failure() async {
        // Arrange / Act
        let expectedError = NSError(domain: "", code: 0, userInfo: nil)
        mockAPIClient.processRequestResult = .failure(APIClientErrorWrapper(error: expectedError, responseData: nil))
        mockErrorMapper.mapErrorResult = expectedError
        
        let request = APIRequestStub.getAPIRquest(authorizationType: .none)
        do {
            let _ = try await repository.emptyResponseRequest(request: request, retries: 0)
            XCTFail("Expected error not thrown")
        } catch {
            // Assert
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func testRequestData_success() async throws {
        // Arrange
        let expectedData = Data("response".utf8)
        mockAPIClient.processRequestResult = .success(expectedData)
        // Act
        let result = try await repository.requestData(request: APIRequestStub.getAPIRquest(), retries: 0)
        // Assert
        XCTAssertEqual(result, expectedData)
    }
    
    func testRequestData_failure() async throws {
        // Arrange
        let expectedError = NSError(domain: "", code: 0, userInfo: nil)
        mockAPIClient.processRequestResult = .failure(APIClientErrorWrapper(error: expectedError, responseData: nil))
        mockErrorMapper.mapErrorResult = expectedError
        // Act & Assert
        do {
            _ = try await repository.requestData(request: APIRequestStub.getAPIRquest(headers: ["Header": "Value"]), retries: 0)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}
