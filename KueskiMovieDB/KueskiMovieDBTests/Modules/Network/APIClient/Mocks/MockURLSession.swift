//
//  MockURLSession.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockURLSession: URLSession {
    var dataTaskToReturn: MockURLSessionDataTask?
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToReturn: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(dataToReturn, responseToReturn, errorToReturn)
        return dataTaskToReturn ?? MockURLSessionDataTask()
    }
}
