//
//  KueskiMovieRequestError.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 19/08/24.
//

import XCTest
@testable import KueskiMovieDB

enum KueskiMovieRequestError: Error, Equatable {
    case invalidResponse
    case invalidURL
    case customError(String)
}
