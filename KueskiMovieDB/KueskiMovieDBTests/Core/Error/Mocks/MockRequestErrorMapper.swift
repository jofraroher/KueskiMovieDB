//
//  MockRequestErrorMapper.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import Foundation
@testable import KueskiMovieDB

final class MockRequestErrorMapper: Mappeable {
    var mapResponseData: Error?

    func map<T>(_ data: Data) -> T? {
        return mapResponseData as? T
    }
}
