//
//  KueskiMovieDatabaseError.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

enum KueskiMovieDatabaseError: Error {
    case invalidEntityType
    case contextNotFound
    case saveFailed(Error)
    case fetchFailed(Error)
    case deleteFailed(Error)
    case undefined
}
