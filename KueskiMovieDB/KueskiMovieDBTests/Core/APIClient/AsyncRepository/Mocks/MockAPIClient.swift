//
//  MockAPIClient.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class MockAPIClient: APIClient {
    
    var processRequestResult: Result<Data, APIClientErrorWrapper>?
    
    func processRequest(_ request: any KueskiMovieDB.APIRequest, retries: Int) async -> Result<Data, KueskiMovieDB.APIClientErrorWrapper> {
        return processRequestResult ?? .failure(APIClientErrorWrapper.init(error: NSError(domain: String(), code: 0), responseData: nil))
    }
}
