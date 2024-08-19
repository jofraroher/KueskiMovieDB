//
//  MockAPIResponseErrorMapper.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

class MockAPIResponseErrorMapper: APIResponseErrorMapper {

    var mapErrorResult: Error?
    
    func mapError(error: APIClientErrorWrapper, requestErrorMapper: Mappeable?) -> Error {
        return mapErrorResult ?? error
    }
}
