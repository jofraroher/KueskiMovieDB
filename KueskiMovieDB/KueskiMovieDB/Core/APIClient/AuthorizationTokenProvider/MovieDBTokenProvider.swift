//
//  MovieDBTokenProvider.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

final class MovieDBTokenProvider: AuthorizationTokenProvider {

    func authorizationToken() async throws -> String {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYzQ2MDJkN2RlYjE0ZjkyMDg3YmViZmY5YjllMDNjYiIsIm5iZiI6MTcyMzc0Mjc3Mi45NzA0NTYsInN1YiI6IjU2NTE4YTdiYzNhMzY4MDcwZjAwYTAxYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nVXWGSEMwcvqgTMO3Xplm4DxmGqHf3q2urHBLaa2mzo"
    }
}
