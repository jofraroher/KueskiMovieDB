//
//  URLSessionAPIClient.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class URLSessionAPIClientTests: XCTestCase {
    private var apiClient: URLSessionAPIClient!
    private var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        apiClient = URLSessionAPIClient(session: mockSession)
    }
    
    override func tearDown() {
        apiClient = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testProcessRequest_success() async {
        // Arrange
        let expectedData = "response".data(using: .utf8)
        mockSession.dataToReturn = expectedData
        mockSession.responseToReturn = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                       statusCode: 200,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        
        let request = APIRequestStub.getAPIRquest(url: URL(string: "https://example.com")!, method: .get, headers: nil, parameters: nil)
        
        // Act
        let result = await apiClient.processRequest(request, retries: 1)
        
        // Assert
        switch result {
        case .success(let data):
            XCTAssertEqual(data, expectedData)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func testProcessRequest_failure() async {
        // Arrange
        mockSession.errorToReturn = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        let request = APIRequestStub.getAPIRquest(url: URL(string: "https://example.com")!, method: .get, headers: nil, parameters: nil)
        
        // Act
        let result = await apiClient.processRequest(request, retries: 1)
        
        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let errorWrapper):
            XCTAssertNotNil(errorWrapper.error)
        }
    }
    
    func testProcessRequest_invalidURL() async {
        // Arrange
        let request = APIRequestStub.getAPIRquest(url: nil, method: .get, headers: nil, parameters: nil)
        
        // Act
        let result = await apiClient.processRequest(request, retries: 1)
        
        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let errorWrapper):
            XCTAssertEqual(errorWrapper.error as? KueskiMovieRequestError, KueskiMovieRequestError.invalidURL)
        }
    }
}
