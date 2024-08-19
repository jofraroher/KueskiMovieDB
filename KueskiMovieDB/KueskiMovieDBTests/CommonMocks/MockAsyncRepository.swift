//
//  MockAsyncRepository.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockAsyncRepository: AsyncRepository {
    
    var shouldThrowError = false
    var mockResponse: MovieResponse?
    var mockData: Data?
    
    func request<Response: Decodable>(
        request: APIRequest,
        responseType: Response.Type,
        retries: Int
    ) async throws -> Response {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }
        if let response = mockResponse as? Response {
            return response
        }
        throw NSError(domain: "MockError", code: 2, userInfo: nil)
    }
    
    func requestData(
        request: APIRequest,
        retries: Int
    ) async throws -> Data {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }
        if let data = mockData {
            return data
        }
        throw NSError(domain: "MockError", code: 2, userInfo: nil)
    }
    
    func emptyResponseRequest(
        request: APIRequest,
        retries: Int
    ) async throws {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }
        // No response expected, so nothing to return
    }
}
