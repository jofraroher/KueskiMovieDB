//
//  KueskiMovieDBError.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

enum KueskiMovieDBError: String, Error {
    case invalidResponse
    case invalidURL
    case missingAuthorizationToken
    case undefined
}
