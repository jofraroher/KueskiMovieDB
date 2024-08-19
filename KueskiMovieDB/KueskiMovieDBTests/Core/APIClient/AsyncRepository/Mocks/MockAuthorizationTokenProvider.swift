//
//  MockAuthorizationTokenProvider.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockAuthorizationTokenProvider: AuthorizationTokenProvider {
    var authorizationTokenResult: String?
    var authorizationTokenError: Error?
    
    func authorizationToken() async throws -> String {
        if let error = authorizationTokenError {
            throw error
        }
        return authorizationTokenResult ?? String()
    }
}
